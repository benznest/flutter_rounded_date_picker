import 'package:flutter/cupertino.dart';

class MaterialRoundedDatePickerStyle {
  TextStyle textStyleYearButton;
  TextStyle textStyleDayButton;
  TextStyle textStyleDayHeader;
  TextStyle textStyleDayOnCalendar;
  TextStyle textStyleDayOnCalendarSelected;
  TextStyle textStyleDayOnCalendarDisabled;
  TextStyle textStyleCurrentDayOnCalendar;
  TextStyle textStyleMonthYearHeader;
  EdgeInsets paddingDatePicker;
  EdgeInsets paddingMonthHeader;
  EdgeInsets paddingActionBar;
  EdgeInsets paddingDateYearHeader;
  double sizeArrow;
  double marginTopArrowPrevious;
  double marginLeftArrowPrevious;
  double marginTopArrowNext;
  double marginRightArrowNext;
  BoxDecoration decorationDateSelected;
  Color colorArrowPrevious;
  Color colorArrowNext;
  Color backgroundPicker;
  Color backgroundActionBar;
  Color backgroundHeaderMonth;
  TextStyle textStyleButtonPositive;
  TextStyle textStyleButtonNegative;
  TextStyle textStyleButtonAction;

  MaterialRoundedDatePickerStyle({
    this.textStyleYearButton,
    this.textStyleDayButton,
    this.textStyleDayHeader,
    this.textStyleDayOnCalendar,
    this.textStyleCurrentDayOnCalendar,
    this.textStyleDayOnCalendarSelected,
    this.textStyleDayOnCalendarDisabled,
    this.textStyleMonthYearHeader,
    this.paddingDatePicker,
    this.paddingActionBar,
    this.paddingMonthHeader,
    this.paddingDateYearHeader,
    this.sizeArrow,
    this.marginRightArrowNext,
    this.marginTopArrowNext,
    this.marginLeftArrowPrevious,
    this.marginTopArrowPrevious,
    this.textStyleButtonNegative,
    this.textStyleButtonPositive,
    this.textStyleButtonAction,
    this.decorationDateSelected,
    this.colorArrowNext,
    this.colorArrowPrevious,
    this.backgroundActionBar,
    this.backgroundPicker,
    this.backgroundHeaderMonth,
  });
}
