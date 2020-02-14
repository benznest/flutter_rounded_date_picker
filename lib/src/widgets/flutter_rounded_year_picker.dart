import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/src/era_mode.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_date_picker_style.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_year_picker_style.dart';

/// A scrollable list of years to allow picking a year.
///
/// The year picker widget is rarely used directly. Instead, consider using
/// [showDatePicker], which creates a date picker dialog.
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// See also:
///
///  * [showDatePicker], which shows a dialog that contains a material design
///    date picker.
///  * [showTimePicker], which shows a dialog that contains a material design
///    time picker.
class FlutterRoundedYearPicker extends StatefulWidget {
  /// Creates a year picker.
  ///
  /// The [selectedDate] and [onChanged] arguments must not be null. The
  /// [lastDate] must be after the [firstDate].
  ///
  /// Rarely used directly. Instead, typically used as part of the dialog shown
  /// by [showDatePicker].
  FlutterRoundedYearPicker(
      {Key key,
      @required this.selectedDate,
      @required this.onChanged,
      @required this.firstDate,
      @required this.lastDate,
      this.era = EraMode.CHRIST_YEAR,
      this.fontFamily,
      this.dragStartBehavior = DragStartBehavior.start,
      this.style})
      : assert(selectedDate != null),
        assert(onChanged != null),
        assert(!firstDate.isAfter(lastDate)),
        super(key: key);

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// Called when the user picks a year.
  final ValueChanged<DateTime> onChanged;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// Era
  final EraMode era;

  /// Font
  final String fontFamily;

  /// style
  final MaterialRoundedYearPickerStyle style;

  @override
  _FlutterRoundedYearPickerState createState() => _FlutterRoundedYearPickerState();
}

class _FlutterRoundedYearPickerState extends State<FlutterRoundedYearPicker> {
  double _itemExtent;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    _itemExtent = widget.style?.heightYearRow ?? 50;
    scrollController = ScrollController(
      // Move the initial scroll position to the currently selected date's year.
      initialScrollOffset: (widget.selectedDate.year - widget.firstDate.year) * _itemExtent,
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData themeData = Theme.of(context);
    final TextStyle style = themeData.textTheme.body1.copyWith(
      fontFamily: widget.fontFamily,
    );
    return ListView.builder(
      dragStartBehavior: widget.dragStartBehavior,
      controller: scrollController,
      itemExtent: _itemExtent,
      itemCount: widget.lastDate.year - widget.firstDate.year + 1,
      itemBuilder: (BuildContext context, int index) {
        final int year = widget.firstDate.year + index;
        final bool isSelected = year == widget.selectedDate.year;
        final TextStyle itemStyle = isSelected
            ? (widget.style?.textStyleYearSelected ??
                themeData.textTheme.headline.copyWith(
                  color: themeData.accentColor,
                  fontFamily: widget.fontFamily,
                ))
            : (widget.style?.textStyleYear ?? style);
        return InkWell(
          key: ValueKey<int>(year),
          onTap: () {
            widget.onChanged(DateTime(
              year,
              widget.selectedDate.month,
              widget.selectedDate.day,
            ));
          },
          child: Center(
            child: Semantics(
              selected: isSelected,
              child: Text(
                "${calculateYearEra(widget.era, year)}",
                style: itemStyle,
              ),
            ),
          ),
        );
      },
    );
  }
}
