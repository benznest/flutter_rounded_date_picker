import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_rounded_date_picker/src/era_mode.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_date_picker_style.dart';
import 'package:flutter_rounded_date_picker/src/widgets/flutter_rounded_day_picker.dart';

/// A scrollable list of months to allow picking a month.
///
/// Shows the days of each month in a rectangular grid with one column for each
/// day of the week.
///
/// The month picker widget is rarely used directly. Instead, consider using
/// [showDatePicker], which creates a date picker dialog.
///
/// See also:
///
///  * [showDatePicker], which shows a dialog that contains a material design
///    date picker.
///  * [showTimePicker], which shows a dialog that contains a material design
///    time picker.
///

const Duration _kMonthScrollDuration = Duration(milliseconds: 200);

class FlutterRoundedMonthPicker extends StatefulWidget {
  /// Creates a month picker.
  ///
  /// Rarely used directly. Instead, typically used as part of the dialog shown
  /// by [showDatePicker].
  FlutterRoundedMonthPicker(
      {Key key,
      @required this.selectedDate,
      @required this.onChanged,
      @required this.firstDate,
      @required this.lastDate,
      this.selectableDayPredicate,
      this.dragStartBehavior = DragStartBehavior.start,
      this.era,
      this.locale,
      this.fontFamily,
      this.style,
      this.borderRadius = 0,
      this.customWeekDays,
      this.builderDay,
      this.listDateDisabled,
      this.onTapDay})
      : assert(selectedDate != null),
        assert(onChanged != null),
        assert(!firstDate.isAfter(lastDate)),
//        assert(selectedDate.isAfter(firstDate) || selectedDate.isAtSameMomentAs(firstDate)),
        super(key: key);

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// Called when the user picks a month.
  final ValueChanged<DateTime> onChanged;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// Optional user supplied predicate function to customize selectable days.
  final SelectableDayPredicate selectableDayPredicate;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// Optional era year.
  final EraMode era;
  final Locale locale;

  /// Font
  final String fontFamily;

  /// Style
  final MaterialRoundedDatePickerStyle style;

  final double borderRadius;

  /// Custom Weekday.
  final List<String> customWeekDays;

  final BuilderDayOfDatePicker builderDay;

  final List<DateTime> listDateDisabled;
  final OnTapDay onTapDay;

  @override
  _FlutterRoundedMonthPickerState createState() => _FlutterRoundedMonthPickerState();
}

class _FlutterRoundedMonthPickerState extends State<FlutterRoundedMonthPicker> with SingleTickerProviderStateMixin {
  static final Animatable<double> _chevronOpacityTween =
      Tween<double>(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeInOut));

  @override
  void initState() {
    super.initState();
    // Initially display the pre-selected date.
    final int monthPage = _monthDelta(widget.firstDate, widget.selectedDate);
    _dayPickerController = PageController(initialPage: monthPage);
    _handleMonthPageChanged(monthPage);
    _updateCurrentDate();

    // Setup the fade animation for chevrons
    _chevronOpacityController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _chevronOpacityAnimation = _chevronOpacityController.drive(
      _chevronOpacityTween,
    );
  }

  @override
  void didUpdateWidget(FlutterRoundedMonthPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      final int monthPage = _monthDelta(widget.firstDate, widget.selectedDate);
      _dayPickerController = PageController(initialPage: monthPage);
      _handleMonthPageChanged(monthPage);
    }
  }

  MaterialLocalizations localizations;
  TextDirection textDirection;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations = MaterialLocalizations.of(context);
    textDirection = Directionality.of(context);
  }

  DateTime _todayDate;
  DateTime _currentDisplayedMonthDate;
  Timer _timer;
  PageController _dayPickerController;
  AnimationController _chevronOpacityController;
  Animation<double> _chevronOpacityAnimation;

  void _updateCurrentDate() {
    _todayDate = DateTime.now();
    final DateTime tomorrow = DateTime(_todayDate.year, _todayDate.month, _todayDate.day + 1);
    Duration timeUntilTomorrow = tomorrow.difference(_todayDate);
    // so we don't miss it by rounding
    timeUntilTomorrow += const Duration(seconds: 1);
    _timer?.cancel();
    _timer = Timer(timeUntilTomorrow, () {
      setState(() => _updateCurrentDate());
    });
  }

  static int _monthDelta(DateTime startDate, DateTime endDate) {
    return (endDate.year - startDate.year) * 12 + endDate.month - startDate.month;
  }

  /// Add months to a month truncated date.
  DateTime _addMonthsToMonthDate(DateTime monthDate, int monthsToAdd) {
    return DateTime(
      monthDate.year + monthsToAdd ~/ 12,
      monthDate.month + monthsToAdd % 12,
    );
  }

  Widget _buildItems(BuildContext context, int index) {
    final DateTime month = _addMonthsToMonthDate(widget.firstDate, index);
    return FlutterRoundedDayPicker(
      key: ValueKey<DateTime>(month),
      selectedDate: widget.selectedDate,
      currentDate: _todayDate,
      onChanged: widget.onChanged,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      displayedMonth: month,
      selectableDayPredicate: widget.selectableDayPredicate,
      dragStartBehavior: widget.dragStartBehavior,
      era: widget.era,
      locale: widget.locale,
      fontFamily: widget.fontFamily,
      style: widget.style,
      borderRadius: widget.borderRadius,
      customWeekDays: widget.customWeekDays,
      builderDay: widget.builderDay,
      listDateDisabled: widget.listDateDisabled,
      onTapDay: widget.onTapDay,
    );
  }

  void _handleNextMonth() {
    if (!_isDisplayingLastMonth) {
      SemanticsService.announce(
        localizations.formatMonthYear(_nextMonthDate),
        textDirection,
      );
      _dayPickerController.nextPage(
        duration: _kMonthScrollDuration,
        curve: Curves.ease,
      );
    }
  }

  void _handlePreviousMonth() {
    if (!_isDisplayingFirstMonth) {
      SemanticsService.announce(
        localizations.formatMonthYear(_previousMonthDate),
        textDirection,
      );
      _dayPickerController.previousPage(
        duration: _kMonthScrollDuration,
        curve: Curves.ease,
      );
    }
  }

  /// True if the earliest allowable month is displayed.
  bool get _isDisplayingFirstMonth {
    return !_currentDisplayedMonthDate.isAfter(
      DateTime(widget.firstDate.year, widget.firstDate.month),
    );
  }

  /// True if the latest allowable month is displayed.
  bool get _isDisplayingLastMonth {
    return !_currentDisplayedMonthDate.isBefore(
      DateTime(widget.lastDate.year, widget.lastDate.month),
    );
  }

  DateTime _previousMonthDate;
  DateTime _nextMonthDate;

  void _handleMonthPageChanged(int monthPage) {
    setState(() {
      _previousMonthDate = _addMonthsToMonthDate(
        widget.firstDate,
        monthPage - 1,
      );
      _currentDisplayedMonthDate = _addMonthsToMonthDate(
        widget.firstDate,
        monthPage,
      );
      _nextMonthDate = _addMonthsToMonthDate(widget.firstDate, monthPage + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      decoration: BoxDecoration(
          color: widget.style?.backgroundPicker,
          borderRadius: orientation == Orientation.landscape
              ? BorderRadius.only(topRight: Radius.circular(widget.borderRadius))
              : null),
      // The month picker just adds month navigation to the day picker, so make
      // it the same height as the DayPicker
//      height: _kMaxDayPickerHeight,
      child: Stack(
        children: <Widget>[
          Semantics(
            sortKey: _MonthPickerSortKey.calendar,
            child: NotificationListener<ScrollStartNotification>(
              onNotification: (_) {
                _chevronOpacityController.forward();
                return false;
              },
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (_) {
                  _chevronOpacityController.reverse();
                  return false;
                },
                child: PageView.builder(
                  dragStartBehavior: widget.dragStartBehavior,
                  key: ValueKey<DateTime>(widget.selectedDate),
                  controller: _dayPickerController,
                  scrollDirection: Axis.horizontal,
                  itemCount: _monthDelta(widget.firstDate, widget.lastDate) + 1,
                  itemBuilder: _buildItems,
                  onPageChanged: _handleMonthPageChanged,
                ),
              ),
            ),
          ),

          /// Arrow Left
          PositionedDirectional(
            top: widget.style?.marginLeftArrowPrevious ?? 0.0,
            start: widget.style?.marginLeftArrowPrevious ?? 8.0,
            child: Semantics(
              sortKey: _MonthPickerSortKey.previousMonth,
              child: FadeTransition(
                opacity: _chevronOpacityAnimation,
                child: IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    size: widget?.style?.sizeArrow,
                    color: widget?.style?.colorArrowPrevious,
                  ),
                  tooltip: _isDisplayingFirstMonth
                      ? null
                      : '${localizations.previousMonthTooltip} ${localizations.formatMonthYear(_previousMonthDate)}',
                  onPressed: _isDisplayingFirstMonth == true ? null : _handlePreviousMonth,
                ),
              ),
            ),
          ),

          /// Arrow Right
          PositionedDirectional(
            top: widget.style?.marginTopArrowNext ?? 0.0,
            end: widget.style?.marginRightArrowNext ?? 8.0,
            child: Semantics(
              sortKey: _MonthPickerSortKey.nextMonth,
              child: FadeTransition(
                opacity: _chevronOpacityAnimation,
                child: IconButton(
                  icon: Icon(
                    Icons.chevron_right,
                    size: widget?.style?.sizeArrow,
                    color: widget?.style?.colorArrowNext,
                  ),
                  tooltip: _isDisplayingLastMonth
                      ? null
                      : '${localizations.nextMonthTooltip} ${localizations.formatMonthYear(_nextMonthDate)}',
                  onPressed: _isDisplayingLastMonth ? null : _handleNextMonth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _chevronOpacityController?.dispose();
    _dayPickerController?.dispose();
    super.dispose();
  }
}

// Defines semantic traversal order of the top-level widgets inside the month
// picker.
class _MonthPickerSortKey extends OrdinalSortKey {
  const _MonthPickerSortKey(double order) : super(order);

  static const _MonthPickerSortKey previousMonth = _MonthPickerSortKey(1.0);
  static const _MonthPickerSortKey nextMonth = _MonthPickerSortKey(2.0);
  static const _MonthPickerSortKey calendar = _MonthPickerSortKey(3.0);
}
