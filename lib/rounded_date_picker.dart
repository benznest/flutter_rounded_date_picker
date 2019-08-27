import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/era_mode.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker_widget.dart';

class RoundedDatePicker {
  static show(BuildContext context,
      {Locale locale,
      DateTime initialDate,
      DateTime firstDate,
      DateTime lastDate,
      ThemeData theme,
      EraMode era = EraMode.CHRIST_YEAR,
      double borderRadius = 16,
      ImageProvider imageHeader,
      String description = "",
      String fontFamily,
      bool barrierDismissible = true,
      Color background = Colors.transparent}) {
    if (initialDate == null) {
      initialDate = DateTime.now();
    }

    if (firstDate == null) {
      firstDate = DateTime(initialDate.year - 1);
    }

    if (lastDate == null) {
      lastDate = DateTime(initialDate.year + 1);
    }

    if (theme == null) {
      theme = ThemeData();
    }

    Future<DateTime> selectedDate = showRoundedDatePicker(
      context: context,
      locale: locale,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      era: era,
      borderRadius: borderRadius,
      imageHeader: imageHeader,
      description: description,
      fontFamily: fontFamily,
      barrierDismissible: barrierDismissible,
      background: background,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: theme,
          child: child,
        );
      },
    );
    return selectedDate;
  }
}
