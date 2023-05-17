import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/src/era_mode.dart';
import 'package:flutter_rounded_date_picker/src/flutter_cupertino_rounded_date_picker_widget.dart';

class CupertinoRoundedDurationPicker {
  static show(BuildContext context,
      {Function(Duration)? onDurationChanged,
      int minuteInterval = 1,
      Duration? initialTimerDuration,
      CupertinoTimerPickerMode initialDurationPickerMode =
          CupertinoTimerPickerMode.hm,
      EraMode era = EraMode.CHRIST_YEAR,
      double borderRadius = 16,
      String? fontFamily,
      Color background = Colors.white,
      Color textColor = Colors.black54,
      BoxConstraints? constraints}) async {
    initialTimerDuration ??= Duration(minutes: 10);

    return await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      constraints: constraints ??
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.5),
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
          initialTimerDuration: initialTimerDuration!,
          mode: initialDurationPickerMode,
          minuteInterval: minuteInterval,
        );
      },
    );
  }
}
