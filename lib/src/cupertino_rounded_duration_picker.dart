import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/src/era_mode.dart';
import 'package:flutter_rounded_date_picker/src/flutter_cupertino_rounded_date_picker_widget.dart';

class CupertinoRoundedDurationPicker {
  static show(
    BuildContext context, {
    Function(Duration) onDurationChanged,
    int minuteInterval = 1,
    Duration initialTimerDuration,
    CupertinoTimerPickerMode initialDurationPickerMode =
        CupertinoTimerPickerMode.hm,
    EraMode era = EraMode.CHRIST_YEAR,
    double borderRadius = 16,
    String fontFamily,
    Color background = Colors.white,
    Color textColor = Colors.black54,
  }) async {
    initialTimerDuration ??= Duration(minutes: 10);

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return FlutterRoundedCupertinoDurationPickerWidget(
          onTimerDurationChanged: (duration) {
            if (onDurationChanged != null) {
              onDurationChanged(duration);
            }
          },
          background: background,
          textColor: textColor,
          borderRadius: borderRadius,
          fontFamily: fontFamily,
          initialTimerDuration: initialTimerDuration,
          mode: initialDurationPickerMode,
          minuteInterval: minuteInterval,
        );
      },
    );
  }
}
