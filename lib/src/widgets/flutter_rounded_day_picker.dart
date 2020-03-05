import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_rounded_date_picker/src/era_mode.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_date_picker_style.dart';
import 'package:flutter_rounded_date_picker/src/thai_date_utils.dart';
import 'dart:math' as math;

/// Displays the days of a given month and allows choosing a day.
///
/// The days are arranged in a rectangular grid with one column for each day of
/// the week.
///
/// The day picker widget is rarely used directly. Instead, consider using
/// [showDatePicker], which creates a date picker dialog.
///
/// See also:
///
///  * [showDatePicker], which shows a dialog that contains a material design
///    date picker.
///  * [showTimePicker], which shows a dialog that contains a material design
///    time picker.
///

const _DayPickerGridDelegate _kDayPickerGridDelegate = _DayPickerGridDelegate();
const double _kDayPickerRowHeight = 42.0;
const int _kMaxDayPickerRowCount = 6; // A 31 day month that starts on Saturday.
// Two extra rows: one for the day-of-week header and one for the month header.
const double _kMaxDayPickerHeight = _kDayPickerRowHeight * (_kMaxDayPickerRowCount + 2);

typedef BuilderDayOfDatePicker = Widget Function(DateTime dateTime, bool isCurrentDay, bool selected, TextStyle defaultTextStyle);
typedef OnTapDay = bool Function(DateTime dateTime, bool available);

class _DayPickerGridDelegate extends SliverGridDelegate {
  const _DayPickerGridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    const int columnCount = DateTime.daysPerWeek;
    final double tileWidth = constraints.crossAxisExtent / columnCount;
    final double viewTileHeight = constraints.viewportMainAxisExtent / (_kMaxDayPickerRowCount + 1);
    final double tileHeight = math.max(_kDayPickerRowHeight, viewTileHeight);

    return SliverGridRegularTileLayout(
      crossAxisCount: columnCount,
      mainAxisStride: tileHeight,
      crossAxisStride: tileWidth,
      childMainAxisExtent: tileHeight,
      childCrossAxisExtent: tileWidth,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_DayPickerGridDelegate oldDelegate) => false;
}

class FlutterRoundedDayPicker extends StatelessWidget {
  /// Creates a day picker.
  ///
  /// Rarely used directly. Instead, typically used as part of a [MonthPicker].
  FlutterRoundedDayPicker(
      {Key key,
      @required this.selectedDate,
      @required this.currentDate,
      @required this.onChanged,
      @required this.firstDate,
      @required this.lastDate,
      @required this.displayedMonth,
      this.selectableDayPredicate,
      this.dragStartBehavior = DragStartBehavior.start,
      this.era,
      this.locale,
      this.fontFamily,
      this.borderRadius,
      this.style,
      this.customWeekDays,
      this.builderDay,
      this.listDateDisabled,
      this.onTapDay})
      : assert(selectedDate != null),
        assert(currentDate != null),
        assert(onChanged != null),
        assert(displayedMonth != null),
        assert(dragStartBehavior != null),
        assert(!firstDate.isAfter(lastDate)),
//        assert(selectedDate.isAfter(firstDate) || selectedDate.isAtSameMomentAs(firstDate)),
        super(key: key);

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// The current date at the time the picker is displayed.
  final DateTime currentDate;

  /// Called when the user picks a day.
  final ValueChanged<DateTime> onChanged;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// The month whose days are displayed by this picker.
  final DateTime displayedMonth;

  /// Optional user supplied predicate function to customize selectable days.
  final SelectableDayPredicate selectableDayPredicate;

  final EraMode era;
  final Locale locale;

  final String fontFamily;

  final double borderRadius;
  final MaterialRoundedDatePickerStyle style;
  final List<String> customWeekDays;
  final BuilderDayOfDatePicker builderDay;
  final List<DateTime> listDateDisabled;
  final OnTapDay onTapDay;

  /// Determines the way that drag start behavior is handled.
  ///
  /// If set to [DragStartBehavior.start], the drag gesture used to scroll a
  /// date picker wheel will begin upon the detection of a drag gesture. If set
  /// to [DragStartBehavior.down] it will begin when a down event is first
  /// detected.
  ///
  /// In general, setting this to [DragStartBehavior.start] will make drag
  /// animation smoother and setting it to [DragStartBehavior.down] will make
  /// drag behavior feel slightly more reactive.
  ///
  /// By default, the drag start behavior is [DragStartBehavior.start].
  ///
  /// See also:
  ///
  ///  * [DragGestureRecognizer.dragStartBehavior], which gives an example for the different behaviors.
  final DragStartBehavior dragStartBehavior;

  /// Builds widgets showing abbreviated days of week. The first widget in the
  /// returned list corresponds to the first day of week for the current locale.
  ///
  /// Examples:
  ///
  /// ```
  /// ┌ Sunday is the first day of week in the US (en_US)
  /// |
  /// S M T W T F S  <-- the returned list contains these widgets
  /// _ _ _ _ _ 1 2
  /// 3 4 5 6 7 8 9
  ///
  /// ┌ But it's Monday in the UK (en_GB)
  /// |
  /// M T W T F S S  <-- the returned list contains these widgets
  /// _ _ _ _ 1 2 3
  /// 4 5 6 7 8 9 10
  /// ```
  List<Widget> _getDayHeaders(
    TextStyle headerStyle,
    MaterialLocalizations localizations,
  ) {
    final List<Widget> result = <Widget>[];
    if (customWeekDays != null) {
      for (int i = 0; i < 7; i++) {
        result.add(ExcludeSemantics(
          child: Center(
              child: Text(
            i < customWeekDays.length ? customWeekDays[i] : "",
            style: headerStyle,
          )),
        ));
      }
    } else {
      for (int i = localizations.firstDayOfWeekIndex; true; i = (i + 1) % 7) {
        final String weekday = localizations.narrowWeekdays[i];
        result.add(ExcludeSemantics(
          child: Center(
              child: Text(
            weekday,
            style: headerStyle,
          )),
        ));
        if (i == (localizations.firstDayOfWeekIndex - 1) % 7) break;
      }
    }

    return result;
  }

  // Do not use this directly - call getDaysInMonth instead.
  static const List<int> _daysInMonth = <int>[
    31,
    -1,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31,
  ];

  /// Returns the number of days in a month, according to the proleptic
  /// Gregorian calendar.
  ///
  /// This applies the leap year logic introduced by the Gregorian reforms of
  /// 1582. It will not give valid results for dates prior to that time.
  static int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear = (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      if (isLeapYear) return 29;
      return 28;
    }
    return _daysInMonth[month - 1];
  }

  /// Computes the offset from the first day of week that the first day of the
  /// [month] falls on.
  ///
  /// For example, September 1, 2017 falls on a Friday, which in the calendar
  /// localized for United States English appears as:
  ///
  /// ```
  /// S M T W T F S
  /// _ _ _ _ _ 1 2
  /// ```
  ///
  /// The offset for the first day of the months is the number of leading blanks
  /// in the calendar, i.e. 5.
  ///
  /// The same date localized for the Russian calendar has a different offset,
  /// because the first day of week is Monday rather than Sunday:
  ///
  /// ```
  /// M T W T F S S
  /// _ _ _ _ 1 2 3
  /// ```
  ///
  /// So the offset is 4, rather than 5.
  ///
  /// This code consolidates the following:
  ///
  /// - [DateTime.weekday] provides a 1-based index into days of week, with 1
  ///   falling on Monday.
  /// - [MaterialLocalizations.firstDayOfWeekIndex] provides a 0-based index
  ///   into the [MaterialLocalizations.narrowWeekdays] list.
  /// - [MaterialLocalizations.narrowWeekdays] list provides localized names of
  ///   days of week, always starting with Sunday and ending with Saturday.
  int _computeFirstDayOffset(int year, int month, MaterialLocalizations localizations) {
    // 0-based day of week, with 0 representing Monday.
    final int weekdayFromMonday = DateTime(year, month).weekday - 1;
    // 0-based day of week, with 0 representing Sunday.
    final int firstDayOfWeekFromSunday = localizations.firstDayOfWeekIndex;
    // firstDayOfWeekFromSunday recomputed to be Monday-based
    final int firstDayOfWeekFromMonday = (firstDayOfWeekFromSunday - 1) % 7;
    // Number of days between the first day of week appearing on the calendar,
    // and the day corresponding to the 1-st of the month.
    return (weekdayFromMonday - firstDayOfWeekFromMonday) % 7;
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    final ThemeData themeData = Theme.of(context);
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final int year = displayedMonth.year;
    final int month = displayedMonth.month;
    final int daysInMonth = getDaysInMonth(year, month);
    final int firstDayOffset = _computeFirstDayOffset(
      year,
      month,
      localizations,
    );

    final List<Widget> labels = _getDayHeaders(style?.textStyleDayHeader ?? themeData.textTheme.caption, localizations);
    for (int i = 0; true; i += 1) {
      // 1-based day of month, e.g. 1-31 for January, and 1-29 for February on
      // a leap year.
      final int day = i - firstDayOffset + 1;
      if (day > daysInMonth) break;
      if (day < 1) {
        labels.add(Container());
      } else {
        final DateTime dayToBuild = DateTime(year, month, day);
        bool disabled = dayToBuild.isAfter(lastDate) || dayToBuild.isBefore(firstDate) || (selectableDayPredicate != null && !selectableDayPredicate(dayToBuild));

        if (listDateDisabled != null) {
          for (DateTime dt in listDateDisabled) {
            if (dt.day == day && dt.month == month && dt.year == year) {
              disabled = true;
              break;
            }
          }
        }

        BoxDecoration decoration;
        TextStyle itemStyle = style?.textStyleDayOnCalendar ??
            themeData.textTheme.body1.copyWith(
              fontFamily: fontFamily,
            );

        final bool isSelectedDay = selectedDate.year == year && selectedDate.month == month && selectedDate.day == day;
        final bool isCurrentDay = currentDate.year == year && currentDate.month == month && currentDate.day == day;
        if (isSelectedDay) {
          // The selected day gets a circle background highlight, and a contrasting text color.
          itemStyle = style?.textStyleDayOnCalendarSelected ??
              themeData.accentTextTheme.body2.copyWith(
                fontFamily: fontFamily,
              );
          decoration = style?.decorationDateSelected ??
              BoxDecoration(
                color: themeData.accentColor,
                shape: BoxShape.circle,
              );
        } else if (disabled) {
          itemStyle = style?.textStyleDayOnCalendarDisabled ??
              themeData.textTheme.body1.copyWith(
                color: themeData.disabledColor,
                fontFamily: fontFamily,
              );
        } else if (isCurrentDay) {
          // The current day gets a different text color.
          itemStyle = style?.textStyleCurrentDayOnCalendar ??
              themeData.textTheme.body2.copyWith(
                color: themeData.accentColor,
                fontFamily: fontFamily,
              );
        }
        Widget dayWidget;
        if (builderDay != null) {
          dayWidget = builderDay(dayToBuild, isCurrentDay, isSelectedDay, itemStyle);
        }

        dayWidget = dayWidget ??
            Container(
              decoration: decoration,
              child: Center(
                child: Semantics(
                  // We want the day of month to be spoken first irrespective of the
                  // locale-specific preferences or TextDirection. This is because
                  // an accessibility user is more likely to be interested in the
                  // day of month before the rest of the date, as they are looking
                  // for the day of month. To do that we prepend day of month to the
                  // formatted full date.
                  label: '${localizations.formatDecimal(day)}, ${localizations.formatFullDate(dayToBuild)}',
                  selected: isSelectedDay,
                  sortKey: OrdinalSortKey(day.toDouble()),
                  child: ExcludeSemantics(
                    child: Text(
                      localizations.formatDecimal(day),
                      style: itemStyle,
                    ),
                  ),
                ),
              ),
            );

        dayWidget = GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            bool allow = true;

            if((dayToBuild.isAtSameMomentAs(firstDate) || dayToBuild.isAfter(firstDate)) && (dayToBuild.isAtSameMomentAs(lastDate) || dayToBuild.isBefore(lastDate))){
              allow = true;
            }else{
              allow = false;
            }

            if (onTapDay != null) {
              allow = onTapDay(dayToBuild, !disabled);
            }

            if (allow) {
              onChanged(dayToBuild);
            }
          },
          child: dayWidget,
          dragStartBehavior: dragStartBehavior,
        );

        labels.add(dayWidget);
      }
    }

    String monthYearHeader = "";
    if (locale != null && locale.languageCode.toLowerCase() == "th") {
      monthYearHeader = "${ThaiDateUtils.getMonthNameFull(displayedMonth.month)} ${calculateYearEra(era, displayedMonth.year)}";
    } else if (era == EraMode.BUDDHIST_YEAR) {
      monthYearHeader = localizations.formatMonthYear(displayedMonth);
      monthYearHeader = monthYearHeader.replaceAll(RegExp("\\d"), "");
      monthYearHeader = monthYearHeader.replaceAll("ค.ศ.", "");
      monthYearHeader = "$monthYearHeader ${calculateYearEra(era, displayedMonth.year)}".replaceAll(RegExp("  "), " ");
    } else {
      monthYearHeader = localizations.formatMonthYear(displayedMonth);
    }

    return Padding(
      padding: style?.paddingDatePicker ?? EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: style?.backgroundHeaderMonth, borderRadius: orientation == Orientation.landscape ? BorderRadius.only(topRight: Radius.circular(borderRadius)) : null),
            padding: style?.paddingMonthHeader,
//            height: _kDayPickerRowHeight,
            child: Center(
              child: ExcludeSemantics(
                child: Text(
                  monthYearHeader,
                  style: style?.textStyleMonthYearHeader ??
                      themeData.textTheme.subhead.copyWith(
                        fontFamily: fontFamily,
                      ),
                ),
              ),
            ),
          ),
          Flexible(
            child: GridView.custom(
              gridDelegate: _kDayPickerGridDelegate,
              childrenDelegate: SliverChildListDelegate(
                labels,
                addRepaintBoundaries: false,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
