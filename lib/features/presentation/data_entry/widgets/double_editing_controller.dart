import 'package:flutter/material.dart';

class DoubleEditingController extends TextEditingController {
  DoubleEditingController({double? value}) {
    if (value != null) text = value.toStringAsFixed(2);
  }

  double? get doubleValue => double.tryParse(text.replaceAll('%', ''));

  set doubleValue(double? val) {
    text = val?.toStringAsFixed(2) ?? '';
  }
}
