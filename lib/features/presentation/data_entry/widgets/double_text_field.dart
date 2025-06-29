import 'package:flutter/material.dart';
import 'package:money_matcher/features/presentation/data_entry/widgets/double_editing_controller.dart';

class DoubleTextField extends StatefulWidget {
  final DoubleEditingController controller;
  final FocusNode focusNode;
  final double? amt;
  final String? tipType;
  final String? labelText;
  final String normalPrefix;
  final String focusedPrefix;

  const DoubleTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.amt,
    this.tipType,
    this.labelText,
    this.normalPrefix = '',
    this.focusedPrefix = '',
  });

  @override
  State<DoubleTextField> createState() => _DoubleTextFieldState();
}

class _DoubleTextFieldState extends State<DoubleTextField> {
  late bool _isFocused;

  @override
  void initState() {
    super.initState();
    _isFocused = widget.focusNode.hasFocus;
    widget.focusNode.addListener(_handleFocusChange);

    // Optionally format text for initial focus state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isFocused) {
        _applyFocusFormatting();
      }
    });
  }

  void _handleFocusChange() {
    if (!mounted) return;

    setState(() {
      _isFocused = widget.focusNode.hasFocus;
    });

    if (_isFocused) {
      _applyFocusFormatting();
    } else {
      _applyBlurFormatting();
    }
  }

  void _applyFocusFormatting() {
    if (widget.tipType == 'percent') {
      final double? value = widget.amt;
      if (value != null) {
        widget.controller.text = value.toStringAsFixed(0);
      }
    }
  }

  void _applyBlurFormatting() {
    if (widget.focusedPrefix == '%') {
      // You could optionally convert to a full precision double here if desired
      final double? value = widget.controller.doubleValue;
      if (value != null) {
        widget.controller.text = value.toString(); // or .toStringAsFixed(2)
      }
    }
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_handleFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.tipType == 'percent'
          ? const TextInputType.numberWithOptions(decimal: false)
          : const TextInputType.numberWithOptions(decimal: true),
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            vertical: 6.0, horizontal: 8.0), // 👈 key line
        labelText:
            (widget.labelText?.isNotEmpty ?? false) ? widget.labelText : null,
        prefixText: _isFocused
            ? widget.tipType == 'percent'
                ? ''
                : widget.focusedPrefix
            : widget.normalPrefix,
        suffixText: _isFocused && widget.tipType == 'percent' ? '%' : null,
        isDense: true, // 👈 this makes the field more compact overall
      ),
    );
  }
}
