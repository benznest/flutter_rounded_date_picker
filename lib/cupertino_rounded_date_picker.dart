import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/era_mode.dart';
import 'package:flutter_rounded_date_picker/flutter_cupertino_rounded_date_picker_widget.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker_widget.dart' as RoundedDatePickerWidget;

class CupertinoRoundedDatePicker {
  static show(BuildContext context,
      {Locale locale,
      DateTime initialDate,
      DateTime minimumDate,
      DateTime maximumDate,
      int minimumYear,
      int maximumYear,
      ThemeData theme,
      Function(DateTime) onDateTimeChanged,
      int minuteInterval = 1,
      bool use24hFormat = false,
      CupertinoDatePickerMode initialDatePickerMode = CupertinoDatePickerMode.date,
      EraMode era = EraMode.CHRIST_YEAR,
      double borderRadius = 16,
      ImageProvider imageHeader,
      String description = "",
      String fontFamily,
      Color background = Colors.white,
      Color textColor = Colors.black54}) async {
    if (initialDate == null) {
      initialDate = DateTime.now();
    }

    if (minimumDate == null) {
      minimumDate = DateTime.now().subtract(Duration(days: 7));
    }

    if (maximumDate == null) {
      maximumDate = DateTime.now().add(Duration(days: 7));
    }

    if (minimumYear == null) {
      minimumYear = DateTime.now().year - 1;
    }

    if (maximumYear == null) {
      maximumYear = DateTime.now().year + 1;
    }

    if (theme == null) {
      theme = ThemeData();
    }

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return FlutterRoundedCupertinoDatePickerWidget(
            use24hFormat: use24hFormat,
            onDateTimeChanged: (dateTime) {
              if (onDateTimeChanged != null) {
                onDateTimeChanged(dateTime);
              }
            },
            era: era,
            background: background,
            textColor:textColor,
            borderRadius: borderRadius,
            imageHeader: imageHeader,
            description: description,
            fontFamily: fontFamily,
            initialDateTime: initialDate,
            mode: initialDatePickerMode,
            minuteInterval: minuteInterval,
            minimumDate: minimumDate,
            maximumDate: maximumDate,
            maximumYear: maximumYear,
            minimumYear: minimumYear,
          );
        });
  }
}
