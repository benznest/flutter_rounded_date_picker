import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter_rounded_date_picker/src/flutter_rounded_button_action.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_date_picker_style.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_year_picker_style.dart';
import 'package:flutter_rounded_date_picker/src/widgets/flutter_rounded_date_picker_header.dart';
import 'package:flutter_rounded_date_picker/src/widgets/flutter_rounded_day_picker.dart';
import 'package:flutter_rounded_date_picker/src/widgets/flutter_rounded_month_picker.dart';
import 'package:flutter_rounded_date_picker/src/widgets/flutter_rounded_year_picker.dart';

class FlutterRoundedDatePickerDialog extends StatefulWidget {
  const FlutterRoundedDatePickerDialog(
      {Key key,
      this.height,
      this.initialDate,
      this.firstDate,
      this.lastDate,
      this.selectableDayPredicate,
      this.initialDatePickerMode,
      this.era,
      this.locale,
      this.borderRadius,
      this.imageHeader,
      this.description = "",
      this.fontFamily,
      this.textNegativeButton,
      this.textPositiveButton,
      this.textActionButton,
      this.onTapActionButton,
      this.styleDatePicker,
      this.styleYearPicker,
      this.customWeekDays,
      this.builderDay,
      this.listDateDisabled,
      this.builderActions,
      this.showHeader = false,
      this.dialogPadding,
      this.onTapDay})
      : super(key: key);

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final SelectableDayPredicate selectableDayPredicate;
  final DatePickerMode initialDatePickerMode;

  ///Modified
  final bool showHeader;
  final Widget builderActions;
  final EdgeInsets dialogPadding;

  /// double height.
  final double height;

  /// Custom era year.
  final EraMode era;
  final Locale locale;

  /// Border
  final double borderRadius;

  ///  Header;
  final ImageProvider imageHeader;
  final String description;

  /// Font
  final String fontFamily;

  /// Button
  final String textNegativeButton;
  final String textPositiveButton;
  final String textActionButton;

  final VoidCallback onTapActionButton;

  /// Style
  final MaterialRoundedDatePickerStyle styleDatePicker;
  final MaterialRoundedYearPickerStyle styleYearPicker;

  /// Custom Weekday
  final List<String> customWeekDays;

  final BuilderDayOfDatePicker builderDay;

  final List<DateTime> listDateDisabled;
  final OnTapDay onTapDay;

  @override
  _FlutterRoundedDatePickerDialogState createState() =>
      _FlutterRoundedDatePickerDialogState();
}

class _FlutterRoundedDatePickerDialogState
    extends State<FlutterRoundedDatePickerDialog> {
  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _mode = widget.initialDatePickerMode;
  }

  bool _announcedInitialDate = false;

  MaterialLocalizations localizations;
  TextDirection textDirection;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations = MaterialLocalizations.of(context);
    textDirection = Directionality.of(context);
    if (!_announcedInitialDate) {
      _announcedInitialDate = true;
      SemanticsService.announce(
        localizations.formatFullDate(_selectedDate),
        textDirection,
      );
    }
  }

  DateTime _selectedDate;
  DatePickerMode _mode;
  final GlobalKey _pickerKey = GlobalKey();

  void _vibrate() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        HapticFeedback.vibrate();
        break;
      case TargetPlatform.iOS:
        break;
    }
  }

  void _handleModeChanged(DatePickerMode mode) {
    _vibrate();
    setState(() {
      _mode = mode;
      if (_mode == DatePickerMode.day) {
        SemanticsService.announce(
          localizations.formatMonthYear(_selectedDate),
          textDirection,
        );
      } else {
        SemanticsService.announce(
          localizations.formatYear(_selectedDate),
          textDirection,
        );
      }
    });
  }

  void _handleYearChanged(DateTime value) {
    if (value.isBefore(widget.firstDate)) {
      value = widget.firstDate;
    } else if (value.isAfter(widget.lastDate)) {
      value = widget.lastDate;
    }
    if (value == _selectedDate) return;

    _vibrate();
    setState(() {
      _mode = DatePickerMode.day;
      _selectedDate = value;
    });
  }

  void _handleDayChanged(DateTime value) {
    _vibrate();
    setState(() {
      _selectedDate = value;
    });
  }

  void _handleCancel() {
    Navigator.of(context).pop();
  }

  void _handleOk() {
    Navigator.of(context).pop(_selectedDate);
  }

  Widget _buildPicker() {
    assert(_mode != null);
    switch (_mode) {
      case DatePickerMode.day:
        return FlutterRoundedMonthPicker(
          key: _pickerKey,
          selectedDate: _selectedDate,
          onChanged: _handleDayChanged,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          era: widget.era,
          locale: widget.locale,
          selectableDayPredicate: widget.selectableDayPredicate,
          fontFamily: widget.fontFamily,
          style: widget.styleDatePicker,
          borderRadius: widget.borderRadius,
          customWeekDays: widget.customWeekDays,
          builderDay: widget.builderDay,
          listDateDisabled: widget.listDateDisabled,
          onTapDay: widget.onTapDay,
        );
      case DatePickerMode.year:
        return FlutterRoundedYearPicker(
          key: _pickerKey,
          selectedDate: _selectedDate,
          onChanged: _handleYearChanged,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          era: widget.era,
          fontFamily: widget.fontFamily,
          style: widget.styleYearPicker,
        );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Widget picker = _buildPicker();

    final Widget actions = widget.builderActions ??
        FlutterRoundedButtonAction(
          textButtonNegative: widget.textNegativeButton,
          textButtonPositive: widget.textPositiveButton,
          onTapButtonNegative: _handleCancel,
          onTapButtonPositive: _handleOk,
          textActionButton: widget.textActionButton,
          onTapButtonAction: widget.onTapActionButton,
          localizations: localizations,
          textStyleButtonNegative:
              widget.styleDatePicker?.textStyleButtonNegative,
          textStyleButtonPositive:
              widget.styleDatePicker?.textStyleButtonPositive,
          textStyleButtonAction: widget.styleDatePicker?.textStyleButtonAction,
          borderRadius: widget.borderRadius,
          paddingActionBar: widget.styleDatePicker?.paddingActionBar,
          background: widget.styleDatePicker?.backgroundActionBar,
        );

    Color backgroundPicker = theme.dialogBackgroundColor;
    if (_mode == DatePickerMode.day) {
      backgroundPicker = widget.styleDatePicker?.backgroundPicker ??
          theme.dialogBackgroundColor;
    } else {
      backgroundPicker = widget.styleYearPicker?.backgroundPicker ??
          theme.dialogBackgroundColor;
    }

    final Dialog dialog = Dialog(
      insetPadding: widget.dialogPadding ??
          EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        assert(orientation != null);
        final Widget header = widget.showHeader
            ? FlutterRoundedDatePickerHeader(
                selectedDate: _selectedDate,
                mode: _mode,
                onModeChanged: _handleModeChanged,
                orientation: orientation,
                era: widget.era,
                borderRadius: widget.borderRadius,
                imageHeader: widget.imageHeader,
                description: widget.description,
                fontFamily: widget.fontFamily,
                style: widget.styleDatePicker,
              )
            : Container();
        switch (orientation) {
          case Orientation.portrait:
            return Container(
              decoration: BoxDecoration(
                color: backgroundPicker,
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  header,
                  if (widget.height == null)
                    Flexible(child: picker)
                  else
                    SizedBox(
                      height: widget.height,
                      child: picker,
                    ),
                  actions,
                ],
              ),
            );
          case Orientation.landscape:
            return Container(
              decoration: BoxDecoration(
                color: backgroundPicker,
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(flex: 1, child: header),
                  Flexible(
                    flex: 2, // have the picker take up 2/3 of the dialog width
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Flexible(child: picker),
                        actions,
                      ],
                    ),
                  ),
                ],
              ),
            );
        }
        return null;
      }),
    );

    return Theme(
      data: theme.copyWith(dialogBackgroundColor: Colors.transparent),
      child: dialog,
    );
  }
}
