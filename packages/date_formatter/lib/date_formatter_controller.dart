import 'package:flutter/material.dart';

class DateFormatterController extends ValueNotifier<String> {
  DateFormatterController({String? formatString})
      : super(formatString == null ? "" : formatString);

  String get formatString => value;

  set formatString(String newFormatString) {
    value = newFormatString;
  }
}
