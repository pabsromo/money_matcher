import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:money_matcher/db/auth_database.dart';
import 'package:money_matcher/db/items_dao.dart';
import 'package:money_matcher/db/tickets_dao.dart';
import 'package:money_matcher/features/presentation/data_entry/screens/item_responsibility_screen.dart';
import 'package:money_matcher/features/presentation/data_entry/widgets/double_editing_controller.dart';
import 'package:money_matcher/features/presentation/data_entry/widgets/double_text_field.dart';
import 'package:money_matcher/features/presentation/data_entry/widgets/selected_images_viewer.dart';

import '../../../../db/images_dao.dart';

class RefineScanScreen extends StatefulWidget {
  final AuthDatabase db;
  final int userId;
  final int eventId;
  final int ticketId;

  const RefineScanScreen({
    super.key,
    required this.db,
    required this.userId,
    required this.eventId,
    required this.ticketId,
  });

  @override
  State<RefineScanScreen> createState() => _RefineScanScreenState();
}

class _RefineScanScreenState extends State<RefineScanScreen> {
  List<String> ocrTexts = [];
  List<String> _refinedTexts = [];
  bool _everythingLoaded = false;

  Ticket? _currTicket;
  late List<Item?> _currItems;
  late List<File> _selectedImages;

  late List<TextEditingController> _itemNameControllers;
  late List<DoubleEditingController> _itemAmtControllers;
  late DoubleEditingController _subtotalAmtController;
  late DoubleEditingController _taxAmtController;
  late DoubleEditingController _tipAmtController;
  late DoubleEditingController _totalAmtController;

  late List<FocusNode> _itemNameFocusNodes;
  late List<FocusNode> _itemAmtFocusNodes;
  late FocusNode _subtotalAmtFocusNode;
  late FocusNode _taxAmtFocusNode;
  late FocusNode _tipAmtFocusNode;
  late FocusNode _totalAmtFocusNode;

  late ImagesDao _imagesDao;
  late TicketsDao _ticketsDao;
  late ItemsDao _itemsDao;

  final _itemLineRX = RegExp(r'.*\${1}\d+\.\d{2}$');
  final _moneyAmtRX = RegExp(r'^\s*\${1}\d+\.\d{2}\s*$');
  final _totalOrTaxRX = RegExp(
      r'\b(?:tax(?:es)?|total)\b(?![^$]*\$ *\d+\.\d{2})',
      caseSensitive: false);
  final _totalRX = RegExp(r'.*total.*', caseSensitive: false);
  final _taxRX = RegExp(r'.*tax.*', caseSensitive: false);

  @override
  void initState() {
    super.initState();
    _imagesDao = ImagesDao(widget.db);
    _ticketsDao = TicketsDao(widget.db);
    _itemsDao = ItemsDao(widget.db);

    _selectedImages = [];

    _initAsync();
  }

  @override
  void dispose() {
    for (var controller in _itemNameControllers) {
      controller.dispose();
    }
    for (var controller in _itemAmtControllers) {
      controller.dispose();
    }
    for (var node in _itemNameFocusNodes) {
      node.dispose();
    }
    for (var node in _itemAmtFocusNodes) {
      node.dispose();
    }

    _subtotalAmtController.dispose();
    _taxAmtController.dispose();
    _tipAmtController.dispose();
    _totalAmtController.dispose();

    _subtotalAmtFocusNode.dispose();
    _taxAmtFocusNode.dispose();
    _tipAmtFocusNode.dispose();
    _totalAmtFocusNode.dispose();

    super.dispose();
  }

  Future<void> _initAsync() async {
    await _initializeData();
    if (!mounted) return;

    await _loadImages();
    if (!mounted) return;

    if (!_currTicket!.isScanned) {
      await _performOCR();
      if (!mounted) return;

      await _cleanOcrResults();
      if (!mounted) return;

      await _extractDataFromOcrResults();
      if (!mounted) return;
    }

    await _loadData();
    if (!mounted) return;

    await _initControllers();
    if (!mounted) return;

    setState(() {
      _everythingLoaded = true;
    });
  }

  Future<void> _initializeData() async {
    final tempTicket = await _ticketsDao.getTicketById(widget.ticketId);

    setState(
      () {
        _currTicket = tempTicket;
      },
    );
  }

  Future<void> _loadImages() async {
    final storedImages = await _imagesDao.getEventImages(widget.eventId);
    final List<File> selectedImages = [];

    for (var image in storedImages) {
      // print('Loading image path: ${image.imagePath}');
      final file = File(image.imagePath);
      if (await file.exists()) {
        selectedImages.add(file);
      } else {
        // print('⚠️ File does not exist: ${image.imagePath}');
      }
    }

    setState(() {
      _selectedImages = selectedImages;
    });
  }

  Future<void> _performOCR() async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    try {
      final results = await Future.wait(
        _selectedImages.map((image) async {
          if (!await image.exists()) {
            return 'File not found: ${image.path}';
          }

          try {
            final inputImage = InputImage.fromFile(image);
            final RecognizedText recognizedText =
                await textRecognizer.processImage(inputImage);

            // Group lines by their vertical position (top coordinate) within a tolerance
            final Map<int, List<String>> linesByTopBucket = {};

            for (final block in recognizedText.blocks) {
              for (final line in block.lines) {
                final rect = line.boundingBox;

                // Bucket top coordinate into 10-pixel bands to group lines roughly on same horizontal level
                final bucket = (rect.top / 60).round();

                linesByTopBucket.putIfAbsent(bucket, () => []);
                linesByTopBucket[bucket]!.add(line.text);
              }
            }

            // Sort buckets by vertical position (top to bottom)
            final sortedBuckets = linesByTopBucket.keys.toList()..sort();

            // Join grouped lines with some spacing to simulate columns merged into a single line
            final mergedLines = sortedBuckets
                .map((bucket) => linesByTopBucket[bucket]!
                    .join('|')) // 4 spaces between columns
                .toList();

            return mergedLines.join('\n');
          } catch (e) {
            return 'Error reading image: ${image.path} - $e';
          }
        }),
      );

      setState(() {
        ocrTexts = results;
        // isLoading = false;
      });
    } catch (e) {
      setState(() {
        ocrTexts = ['OCR failed: $e'];
        // isLoading = false;
      });
    } finally {
      textRecognizer.close();
    }
  }

  Future<void> _cleanOcrResults() async {
    // Go through and keep the lines that are line item, tax, or totals

    // Go through and find totals or taxes without moneys and combine with moneys if around by one
    for (var i = 0; i < ocrTexts.length; i++) {
      final imageLines = ocrTexts[i].split('\n');
      for (var j = 0; j < imageLines.length - 1; j++) {
        if (_moneyAmtRX.hasMatch(imageLines[j]) &&
            _totalOrTaxRX.hasMatch(imageLines[j + 1])) {
          final moneyAmt = imageLines[j];
          final totalOrTax = imageLines[j + 1];
          final combined = "$totalOrTax $moneyAmt";

          imageLines.remove(moneyAmt);
          imageLines.remove(totalOrTax);
          imageLines.insert(j, combined);

          ocrTexts.removeAt(i);
          ocrTexts.insert(i, imageLines.join('\n'));
        } else if (_totalOrTaxRX.hasMatch(imageLines[j]) &&
            _moneyAmtRX.hasMatch(imageLines[j + 1])) {
          final moneyAmt = imageLines[j + 1];
          final totalOrTax = imageLines[j];
          final combined = "$totalOrTax $moneyAmt";

          imageLines.remove(moneyAmt);
          imageLines.remove(totalOrTax);
          imageLines.insert(j, combined);

          ocrTexts.removeAt(i);
          ocrTexts.remove(totalOrTax);
          ocrTexts.insert(i, combined);
        }
      }
    }

    // Go through and only keep what counts as a line item, tax, or total
    List<String> refinedTexts = [];
    // Go through and separate total and tax
    for (var ticketString in ocrTexts) {
      final newTicketStrings = [];
      for (var line in ticketString.split('\n')) {
        if (_itemLineRX.hasMatch(line)) {
          newTicketStrings.add(line);
        }
        // otherwise don't add it
      }
      refinedTexts.add(newTicketStrings.join('\n'));
    }

    setState(() {
      _refinedTexts = refinedTexts;
    });
  }

  Future<void> _extractDataFromOcrResults() async {
    // Try splitting line items with their amts
    List<Item> localItems = [];
    for (var refinedText in _refinedTexts) {
      final splitLines = refinedText.split('\n');
      for (var line in splitLines) {
        final splitLine = line.split('|\$');
        if (!_totalOrTaxRX.hasMatch(splitLine[0])) {
          localItems.add(Item(
              id: 0,
              ticket_id: 0,
              name: splitLine[0],
              amount: double.parse(splitLine[1]),
              currency: 'USD'));
        }
      }
    }

    // Persist Items and calculate line item amts to equal subtotal
    double calculatedSubtotal = await _calculateSubtotal(localItems);

    for (var item in localItems) {
      _itemsDao.createItem(widget.ticketId, item.name, item.amount, null);
    }

    // Match for subtotal and total and udpate
    for (var refinedText in _refinedTexts) {
      final splitLines = refinedText.split('\n');
      for (var line in splitLines) {
        final lineAmt = double.parse(line.split('|\$')[1]);
        if (_totalRX.hasMatch(line) && lineAmt == calculatedSubtotal) {
          _ticketsDao.updateSubtotal(widget.ticketId, lineAmt);
        }
        if (_totalRX.hasMatch(line) && lineAmt != calculatedSubtotal) {
          _ticketsDao.updateTotal(widget.ticketId, lineAmt);
        }
        if (_taxRX.hasMatch(line) && lineAmt != calculatedSubtotal) {
          _ticketsDao.updateTax(widget.ticketId, lineAmt);
        }
      }
    }

    _ticketsDao.updateIsScannedById(_currTicket!.id, true);
  }

  Future<void> _loadData() async {
    final currItems = await _itemsDao.getItemsByTicketId(widget.ticketId);

    Ticket? currTicket = await _ticketsDao.getTicketById(widget.ticketId);

    // TODO: Maybe change this later so that when the user adds an item it
    //        prompts them asking if they want to auto calculate subtotal, tax, tip, and total
    final subtotal = await _calculateSubtotal(currItems);
    double tip = currTicket!.tipInDollars;
    if (currTicket.tipType == 'percent') {
      tip = await _calculateTip(subtotal, currTicket.tipInPercent);
    }
    final total = await _calculateTotal(subtotal, currTicket.taxes, tip);

    await _ticketsDao.updateSubtotal(widget.ticketId, subtotal);
    await _ticketsDao.updateTipInDollars(widget.ticketId, tip);
    await _ticketsDao.updateTotal(widget.ticketId, total);

    currTicket = await _ticketsDao.getTicketById(widget.ticketId);

    setState(() {
      _currItems = currItems;
      _currTicket = currTicket;
    });
  }

  Future<double> _calculateSubtotal(List<Item> items) async {
    double calculatedSubtotal = 0;
    for (var item in items) {
      calculatedSubtotal += item.amount;
    }
    return calculatedSubtotal;
  }

  Future<double> _calculateTotal(
      double subtotal, double taxes, double tip) async {
    return subtotal + taxes + tip;
  }

  Future<double> _calculateTip(double subtotal, double tip) async {
    return subtotal * tip / 100;
  }

  Future<void> _initControllers() async {
    if (!mounted) return;

    _itemNameControllers = [];
    _itemAmtControllers = [];
    _itemNameFocusNodes = [];
    _itemAmtFocusNodes = [];
    _subtotalAmtController = DoubleEditingController();
    _taxAmtController = DoubleEditingController();
    _tipAmtController = DoubleEditingController();
    _totalAmtController = DoubleEditingController();
    _subtotalAmtFocusNode = FocusNode();
    _taxAmtFocusNode = FocusNode();
    _tipAmtFocusNode = FocusNode();
    _totalAmtFocusNode = FocusNode();

    for (int i = 0; i < _currItems.length; i++) {
      final item = _currItems[i]!;

      final itemId = item.id;

      final nameController = TextEditingController(text: item.name);
      final amtController = DoubleEditingController(value: item.amount);

      final nameFocusNode = FocusNode();
      final amtFocusNode = FocusNode();

      nameFocusNode.addListener(() async {
        if (!mounted) return;
        if (!nameFocusNode.hasFocus) {
          final newName = nameController.text.trim();
          await _itemsDao.updateItemNameById(itemId, newName);
          await _loadData();
          _updateControllerValues();
        }
      });

      amtFocusNode.addListener(() async {
        if (!mounted) return;
        if (!amtFocusNode.hasFocus) {
          final newAmt = amtController.value;
          await _itemsDao.updateItemAmtById(itemId, double.parse(newAmt.text));
          await _loadData();
          _updateControllerValues();
        }
      });

      _itemNameControllers.add(nameController);
      _itemAmtControllers.add(amtController);
      _itemNameFocusNodes.add(nameFocusNode);
      _itemAmtFocusNodes.add(amtFocusNode);
    }

    // Single Controllers
    _subtotalAmtController =
        DoubleEditingController(value: _currTicket!.subtotal);
    _taxAmtController = DoubleEditingController(value: _currTicket!.taxes);
    _tipAmtController =
        DoubleEditingController(value: _currTicket!.tipInDollars);
    _totalAmtController = DoubleEditingController(value: _currTicket!.total);

    final subtotalAmtFocusNode = FocusNode();
    final taxAmtFocusNode = FocusNode();
    final tipAmtFocusNode = FocusNode();
    final totalAmtFocusNode = FocusNode();

    subtotalAmtFocusNode.addListener(() async {
      if (!subtotalAmtFocusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!mounted) return;
          final newAmt = _subtotalAmtController.doubleValue;
          if (newAmt != null) {
            await _ticketsDao.updateSubtotal(_currTicket!.id, newAmt);
            await _loadData();
            _updateControllerValues();
          }
        });
      }
    });

    taxAmtFocusNode.addListener(() async {
      if (!taxAmtFocusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!mounted) return;
          final newAmt = _taxAmtController.doubleValue;
          if (newAmt != null) {
            await _ticketsDao.updateTax(_currTicket!.id, newAmt);
            await _loadData();
            _updateControllerValues();
          }
        });
      }
    });

    tipAmtFocusNode.addListener(() async {
      if (!tipAmtFocusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!mounted) return;
          final newAmt = _tipAmtController.doubleValue;
          if (newAmt != null) {
            if (_currTicket!.tipType == 'percent') {
              await _ticketsDao.updateTipInPercent(_currTicket!.id, newAmt);
              await _loadData();
              await _updateControllerValues();
            } else {
              await _ticketsDao.updateTipInDollars(_currTicket!.id, newAmt);
              await _loadData();
              await _updateControllerValues();
            }
          }
        });
      }
    });

    totalAmtFocusNode.addListener(() async {
      if (!totalAmtFocusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!mounted) return;
          final newAmt = _totalAmtController.doubleValue;
          if (newAmt != null) {
            await _ticketsDao.updateTotal(_currTicket!.id, newAmt);
            await _loadData();
            _updateControllerValues();
          }
        });
      }
    });

    _subtotalAmtFocusNode = subtotalAmtFocusNode;
    _taxAmtFocusNode = taxAmtFocusNode;
    _tipAmtFocusNode = tipAmtFocusNode;
    _totalAmtFocusNode = totalAmtFocusNode;
  }

  Future<void> _updateControllerValues() async {
    // for (int i = 0; i < _currItems.length; i++) {
    //   final item = _currItems[i]!;

    //   final nameController = TextEditingController(text: item.name);
    //   final amtController = DoubleEditingController(value: item.amount);

    //   setState(
    //     () {
    //       _itemNameControllers.add(nameController);
    //       _itemAmtControllers.add(amtController);
    //     },
    //   );
    // }
    setState(() {
      for (int i = 0; i < _currItems.length; i++) {
        _itemNameControllers[i].text = _currItems[i]!.name;
        _itemAmtControllers[i].text = _currItems[i]!.amount.toStringAsFixed(2);
      }
      _subtotalAmtController.text = _currTicket!.subtotal.toStringAsFixed(2);
      _taxAmtController.text = _currTicket!.taxes.toStringAsFixed(2);
      _tipAmtController.text = _currTicket!.tipInDollars.toStringAsFixed(2);
      _totalAmtController.text = _currTicket!.total.toStringAsFixed(2);
    });
  }

  void _addItem() async {
    final itemId = await _itemsDao.createItem(widget.ticketId, '', 0, null);

    final nameController = TextEditingController(text: '');
    final amtController = DoubleEditingController(value: 0);

    final nameFocusNode = FocusNode();
    final amtFocusNode = FocusNode();

    nameFocusNode.addListener(() async {
      if (!mounted) return;
      if (!nameFocusNode.hasFocus) {
        final newName = nameController.text.trim();
        await _itemsDao.updateItemNameById(itemId, newName);
      }
    });

    amtFocusNode.addListener(() async {
      if (!mounted) return;
      if (!amtFocusNode.hasFocus) {
        final newAmt = amtController.value;
        await _itemsDao.updateItemAmtById(itemId, double.parse(newAmt.text));
      }
    });

    setState(
      () {
        _itemNameControllers.add(nameController);
        _itemAmtControllers.add(amtController);
        _itemNameFocusNodes.add(nameFocusNode);
        _itemAmtFocusNodes.add(amtFocusNode);
      },
    );

    await _loadData();
    await _updateControllerValues();
  }

  void _deleteItem(int id) async {
    await _itemsDao.deleteItem(id);
    await _loadData();
    await _updateControllerValues();
  }

  Future<void> _done() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ItemResponsibilityScreen(
                db: widget.db,
                userId: widget.userId,
                eventId: widget.eventId,
                ticketId: widget.ticketId)));
  }

  @override
  Widget build(BuildContext context) {
    if (!_everythingLoaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      key: const Key('refineScanScreen'),
      appBar: AppBar(
        title: const Text('Refine Scan'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: SelectedImagesViewer(
              selectedImages: _selectedImages,
              onMoveUp: null,
              onMoveDown: null,
              onDelete: null,
              isEditable: false,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xFFFFF9E5), // Pastel yellow background
              // padding:
              //     const EdgeInsets.all(8), // Padding around the scroll area
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(_currItems.length, (index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4, // Give more space to item name
                              child: TextField(
                                controller: _itemNameControllers[index],
                                focusNode: _itemNameFocusNodes[index],
                                decoration: const InputDecoration(
                                  labelText: 'Item Name',
                                ),
                              ),
                            ),
                            const SizedBox(width: 12), // Space between inputs
                            Expanded(
                              flex: 3, // Less space for amount
                              child: DoubleTextField(
                                  controller: _itemAmtControllers[index],
                                  focusNode: _itemAmtFocusNodes[index],
                                  labelText: 'Amount',
                                  normalPrefix: '\$',
                                  focusedPrefix: '\$'),
                            ),
                            // TODO: Add functionality to split an item. Present dialog that helps user choose how many times to split and what to name and amount each item
                            // Expanded(
                            //   flex: 1,
                            //   child: IconButton(
                            //     icon: const Icon(Icons.call_split),
                            //     onPressed: () {},
                            //   ),
                            // ),
                            Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: const Icon(Icons.cancel_outlined),
                                  onPressed: () async {
                                    _deleteItem(_currItems[index]!.id);
                                  },
                                )),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F4EA), // soft forest green background
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 2),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFF374151), // same red as the text
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Subtotal',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF374151), // pastel red text
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                        ),
                        child: Text(
                          '\$${_currTicket!.subtotal.toStringAsFixed(2)}',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 2),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFF374151), // same red as the text
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Taxes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF374151), // pastel red text
                          ),
                        ),
                      ),
                      DoubleTextField(
                        controller: _taxAmtController,
                        focusNode: _taxAmtFocusNode,
                        normalPrefix: '\$',
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 2),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(
                                        0xFF374151), // same red as the text
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Tip(notax)',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF374151), // pastel red text
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final tipMode = _currTicket!.tipType == 'dollar'
                                  ? 'percent'
                                  : 'dollar';
                              await _ticketsDao.updateTipType(
                                  _currTicket!.id, tipMode);
                              await _ticketsDao.updateTipInDollars(
                                  _currTicket!.id, 0);
                              await _ticketsDao.updateTipInPercent(
                                  _currTicket!.id, 0);
                              await _loadData();
                              await _updateControllerValues();
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                _currTicket!.tipType == 'dollar' ? '\$' : '%',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      DoubleTextField(
                        controller: _tipAmtController,
                        focusNode: _tipAmtFocusNode,
                        labelText: '',
                        amt: _currTicket!.tipInPercent,
                        tipType: _currTicket!.tipType,
                        normalPrefix: '\$',
                        focusedPrefix: _currTicket!.tipType == 'dollar'
                            ? '\$'
                            : '%', // or some dynamic value
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(
                          0xFFFFEBEB), // softer red for total section
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 2),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    Color(0xFFB91C1C), // same red as the text
                                width: 2.0,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Full Total',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFB91C1C), // pastel red text
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          child: Text(
                            '\$${_currTicket!.total.toStringAsFixed(2)}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 10,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.blueAccent,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          type: BottomNavigationBarType.fixed, // fixed or shifting
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Item'),
            BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Done')
          ],
          onTap: (index) {
            setState(() {
              switch (index) {
                case 0:
                  _addItem();
                  break;
                case 1:
                  _done();
                  break;
                default:
              }
            });
          }),
    );
  }
}
