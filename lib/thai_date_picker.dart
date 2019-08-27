import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_thai_date_picker_widget.dart';

class ThaiDatePicker {
  static show(BuildContext context) {
    Future<DateTime> selectedDate = showThaiDatePicker(
      context: context,
//      locale: Locale("th", "TH"),
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(),
          child: child,
        );
      },
    );
    return selectedDate;
  }
}
