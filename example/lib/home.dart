import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_date_picker_style.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_year_picker_style.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime dateTime;
  Duration duration;

  @override
  void initState() {
    dateTime = DateTime.now();
    duration = Duration(minutes: 10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildBody() {
      return Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Date Time selected",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    "$dateTime",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Duration Selected",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                  Text(
                    "$duration",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 50),
              children: <Widget>[
                const SizedBox(height: 16),
                FloatingActionButton.extended(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                      borderRadius: 2,
                    );
                    print(newDateTime);
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  label: const Text("Material Calendar (Original)"),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Rounded",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      locale: Locale('en', 'US'),
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                      borderRadius: 16,
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  label: const Text("Rounded Calendar (English)"),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      locale: Locale("th", "TH"),
                      era: EraMode.BUDDHIST_YEAR,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(Duration(days: 3)),
                      lastDate: DateTime.now().add(Duration(days: 3)),
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  label: Text("Rounded Calendar (Thai)"),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      locale: Locale("zh", "CN"),
                      theme: ThemeData(primarySwatch: Colors.pink),
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  label: Text("Rounded Calendar (Chinese)"),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      background: Colors.white,
                        context: context,
                        theme: ThemeData(primarySwatch: Colors.deepPurple),
                        era: EraMode.BUDDHIST_YEAR,
                        styleDatePicker: MaterialRoundedDatePickerStyle(
                          textStyleDayButton: TextStyle(fontSize: 36, color: Colors.white),
                          textStyleYearButton: TextStyle(
                            fontSize: 52,
                            color: Colors.white,
                          ),
                          textStyleDayHeader: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          textStyleCurrentDayOnCalendar:
                              TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                          textStyleDayOnCalendar: TextStyle(fontSize: 28, color: Colors.white),
                          textStyleDayOnCalendarSelected:
                              TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                          textStyleDayOnCalendarDisabled: TextStyle(fontSize: 28, color: Colors.white.withOpacity(0.1)),
                          textStyleMonthYearHeader:
                              TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                          paddingDatePicker: EdgeInsets.all(0),
                          paddingMonthHeader: EdgeInsets.all(32),
                          paddingActionBar: EdgeInsets.all(16),
                          paddingDateYearHeader: EdgeInsets.all(32),
                          sizeArrow: 50,
                          colorArrowNext: Colors.white,
                          colorArrowPrevious: Colors.white,
                          marginLeftArrowPrevious: 16,
                          marginTopArrowPrevious: 16,
                          marginTopArrowNext: 16,
                          marginRightArrowNext: 32,
                          textStyleButtonAction: TextStyle(fontSize: 28, color: Colors.white),
                          textStyleButtonPositive:
                              TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                          textStyleButtonNegative: TextStyle(fontSize: 28, color: Colors.white.withOpacity(0.5)),
                          decorationDateSelected: BoxDecoration(color: Colors.orange[600], shape: BoxShape.circle),
                          backgroundPicker: Colors.deepPurple[400],
                          backgroundActionBar: Colors.deepPurple[300],
                          backgroundHeaderMonth: Colors.deepPurple[300],
                        ),
                        styleYearPicker: MaterialRoundedYearPickerStyle(
                          textStyleYear: TextStyle(fontSize: 40, color: Colors.white),
                          textStyleYearSelected:
                              TextStyle(fontSize: 56, color: Colors.white, fontWeight: FontWeight.bold),
                          heightYearRow: 100,
                          backgroundPicker: Colors.deepPurple[400],
                        ),
                        textActionButton: "ACTION",
                        onTapActionButton: (){
                           //
                        },
                        textPositiveButton: "OK",
                        textNegativeButton: "CANCEL",
                        customWeekDays: ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"],
                        listDateDisabled: [
                          DateTime.now().subtract(Duration(days: 2)),
                          DateTime.now().subtract(Duration(days: 4)),
                          DateTime.now().subtract(Duration(days: 6)),
                          DateTime.now().subtract(Duration(days: 8)),
                          DateTime.now().subtract(Duration(days: 10)),
                          DateTime.now().add(Duration(days: 2)),
                          DateTime.now().add(Duration(days: 4)),
                          DateTime.now().add(Duration(days: 6)),
                          DateTime.now().add(Duration(days: 8)),
                          DateTime.now().add(Duration(days: 10)),
                        ],
                        onTapDay: (DateTime dateTime, bool available) {
                          if (!available) {
                            showDialog(
                                context: context,
                                builder: (c) => CupertinoAlertDialog(title: Text("This date cannot be selected."),actions: <Widget>[
                                  CupertinoDialogAction(child: Text("OK"),onPressed: (){
                                    Navigator.pop(context);
                                  },)
                                ],));
                          }
                          return available;
                        },
//                        builderDay:
//                            (DateTime dateTime, bool isCurrentDay, bool isSelected, TextStyle defaultTextStyle) {
//                          if (isSelected) {
//                            return Container(
//                              decoration: BoxDecoration(color: Colors.orange[600], shape: BoxShape.circle),
//                              child: Center(
//                                child: Text(
//                                  dateTime.day.toString(),
//                                  style: defaultTextStyle,
//                                ),
//                              ),
//                            );
//                          }
//
//                          if (dateTime.day == 10) {
//                            return Container(
//                              decoration: BoxDecoration(
//                                  border: Border.all(color: Colors.pink[300], width: 4), shape: BoxShape.circle),
//                              child: Center(
//                                child: Text(
//                                  dateTime.day.toString(),
//                                  style: defaultTextStyle,
//                                ),
//                              ),
//                            );
//                          }
//                          if (dateTime.day == 12) {
//                            return Container(
//                              decoration: BoxDecoration(
//                                  border: Border.all(color: Colors.pink[300], width: 4), shape: BoxShape.circle),
//                              child: Center(
//                                child: Text(
//                                  dateTime.day.toString(),
//                                  style: defaultTextStyle,
//                                ),
//                              ),
//                            );
//                          }
//
//                          return Container(
//                            child: Center(
//                              child: Text(
//                                dateTime.day.toString(),
//                                style: defaultTextStyle,
//                              ),
//                            ),
//                          );
//                        }
                        );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  label: Text("Rounded Calendar with Custom style (Example on Pixel C)"),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      locale: Locale('en', 'US'),
                      initialDate: DateTime.now().subtract(Duration(days: 1)),
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                      listDateDisabled:[DateTime.now()],
                      height: 320,
                      borderRadius: 50,
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  label: const Text("Rounded Calendar disabled date"),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Theme",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      theme: ThemeData(primarySwatch: Colors.pink),
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  label: Text("Rounded Calendar with Theme"),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      theme: ThemeData(
                        primaryColor: Colors.red[400],
                        accentColor: Colors.green[800],
                        dialogBackgroundColor: Colors.purple[50],
                        textTheme: TextTheme(
                          bodyText2: TextStyle(color: Colors.red),
                          caption: TextStyle(color: Colors.blue),
                        ),
                        disabledColor: Colors.orange,
                        accentTextTheme: TextTheme(
                          bodyText1: TextStyle(color: Colors.green[200]),
                        ),
                      ),
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  label: const Text("Rounded Calendar with Custom Theme"),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      theme: ThemeData.dark(),
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  label: const Text("Rounded Calendar with Dark Theme"),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      theme: ThemeData(primarySwatch: Colors.blue),
                      imageHeader: AssetImage(
                        "assets/images/calendar_header.jpg",
                      ),
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  label: const Text("Rounded Calendar and Image Header"),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      theme: ThemeData(primarySwatch: Colors.blue),
                      imageHeader: AssetImage(
                        "assets/images/calendar_header_rainy.jpg",
                      ),
                      fontFamily: "Mali",
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  label: const Text("Rounded Calendar and Custom Font"),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      textNegativeButton: "CUSTOM CANCEL",
                      textPositiveButton: "CUSTOM OK",
                      textActionButton: "TODAY",
                      onTapActionButton: () {
                        Navigator.of(context).pop(DateTime.now());
                      },
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  label: const Text("Rounded Calendar and Custom buttons"),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Year Picker",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      initialDatePickerMode: DatePickerMode.year,
                      theme: ThemeData(primarySwatch: Colors.green),
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  label: const Text("Rounded Year Picker"),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Time Picker",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () async {
                    TimeOfDay newTime = await showRoundedTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        leftBtn: "NOW",
                        onLeftBtn: () {
                          Navigator.of(context).pop(TimeOfDay.now());
                        });
                    if (newTime != null) {
                      setState(() {
                        dateTime = DateTime(
                          dateTime.year,
                          dateTime.month,
                          dateTime.day,
                          newTime.hour,
                          newTime.minute,
                        );
                      });
                    }
                  },
                  label: const Text("Rounded Time Picker"),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Cupertino Date Picker ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () async {
                    DateTime newDateTime = await CupertinoRoundedDatePicker.show(
                      context,
                      fontFamily: "Mali",
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  label: const Text("Cupertino Rounded Date Picker"),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () {
                    CupertinoRoundedDatePicker.show(
                      context,
                      era: EraMode.BUDDHIST_YEAR,
                      fontFamily: "Mali",
                      textColor: Colors.white,
                      background: Colors.red[300],
                      borderRadius: 16,
                      initialDatePickerMode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (newDateTime) {
                        setState(() => dateTime = newDateTime);
                      },
                    );
                  },
                  label: const Text("Cupertino Rounded Date Picker with Theme"),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () async {
                    CupertinoRoundedDatePicker.show(
                      context,
                      initialDatePickerMode: CupertinoDatePickerMode.time,
                      era: EraMode.BUDDHIST_YEAR,
                      fontFamily: "Mali",
                      textColor: Colors.white,
                      background: Colors.green[300],
                      onDateTimeChanged: (newDateTime) {
                        setState(() => dateTime = newDateTime);
                      },
                    );
                  },
                  label: const Text("Cupertino Rounded Time Picker"),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Cupertino Duration Picker ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () async {
                    CupertinoRoundedDurationPicker.show(
                      context,
                      initialTimerDuration: duration,
                      initialDurationPickerMode: CupertinoTimerPickerMode.hms,
                      fontFamily: "Mali",
                      onDurationChanged: (newDuration) {
                        setState(() => duration = newDuration);
                      },
                    );
                  },
                  label: const Text("Cupertino Rounded Duration Picker"),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Rounded Date Picker'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: _buildBody(),
      ),
    );
  }
}
