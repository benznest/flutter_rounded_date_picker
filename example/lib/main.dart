import 'dart:ui' as prefix0;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/rounded_date_picker.dart';
import 'package:flutter_rounded_date_picker/era_mode.dart';
import 'package:flutter_rounded_date_picker/cupertino_rounded_date_picker.dart';
import 'package:flutter_rounded_date_picker/cupertino_rounded_duration_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Locale('th', 'TH'),
        supportedLocales: [
          const Locale('en', 'US'), // English
          const Locale('th', 'TH'), // Thai
        ],
        home: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Rounded Date Picker'),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Date Time selected",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                          ),
                          Text(
                            "$dateTime",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "Duration Selected",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                          ),
                          Text(
                            "$duration",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(bottom: 50),
                      children: <Widget>[
                        SizedBox(
                          height: 16,
                        ),
                        FloatingActionButton.extended(
                            onPressed: () async {
                              DateTime newDateTime = await RoundedDatePicker.show(context,
                                  initialDate: DateTime.now(), firstDate: DateTime(DateTime.now().year - 1), lastDate: DateTime(DateTime.now().year + 1), borderRadius: 2);
                              if (newDateTime != null) {
                                setState(() {
                                  dateTime = newDateTime;
                                });
                              }
                            },
                            label: Text("Material Calendar (Original)")),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Rounded",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FloatingActionButton.extended(
                            onPressed: () async {
                              DateTime newDateTime = await RoundedDatePicker.show(context,
                                  initialDate: DateTime.now(), firstDate: DateTime(DateTime.now().year - 1), lastDate: DateTime(DateTime.now().year + 1), borderRadius: 16);
                              if (newDateTime != null) {
                                setState(() {
                                  dateTime = newDateTime;
                                });
                              }
                            },
                            label: Text("Rounded Calendar (English)")),
                        SizedBox(
                          height: 8,
                        ),
                        FloatingActionButton.extended(
                            onPressed: () async {
                              DateTime newDateTime = await RoundedDatePicker.show(context, locale: Locale("th", "TH"), era: EraMode.BUDDHIST_YEAR);
                              if (newDateTime != null) {
                                setState(() {
                                  dateTime = newDateTime;
                                });
                              }
                            },
                            label: Text("Rounded Calendar (Thai)")),
                        SizedBox(
                          height: 8,
                        ),
                        FloatingActionButton.extended(
                            onPressed: () async {
                              DateTime newDateTime = await RoundedDatePicker.show(context, locale: Locale("zh", "CN"), theme: ThemeData(primarySwatch: Colors.pink));
                              if (newDateTime != null) {
                                setState(() {
                                  dateTime = newDateTime;
                                });
                              }
                            },
                            label: Text("Rounded Calendar (Chinese)")),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Theme",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FloatingActionButton.extended(
                            onPressed: () async {
                              DateTime newDateTime = await RoundedDatePicker.show(context, theme: ThemeData(primarySwatch: Colors.pink));
                              if (newDateTime != null) {
                                setState(() {
                                  dateTime = newDateTime;
                                });
                              }
                            },
                            label: Text("Rounded Calendar with Theme")),
                        SizedBox(
                          height: 8,
                        ),
                        FloatingActionButton.extended(
                            onPressed: () async {
                              DateTime newDateTime = await RoundedDatePicker.show(context,
                                  theme: ThemeData(
                                      primaryColor: Colors.red[400],
                                      accentColor: Colors.green[800],
                                      dialogBackgroundColor: Colors.purple[50],
                                      textTheme: TextTheme(body1: TextStyle(color: Colors.red), caption: TextStyle(color: Colors.blue)),
                                      disabledColor: Colors.orange,
                                      accentTextTheme: TextTheme(body2: TextStyle(color: Colors.green[200]))));
                              if (newDateTime != null) {
                                setState(() {
                                  dateTime = newDateTime;
                                });
                              }
                            },
                            label: Text("Rounded Calendar with Custom Theme")),
                        SizedBox(
                          height: 8,
                        ),
                        FloatingActionButton.extended(
                            onPressed: () async {
                              DateTime newDateTime = await RoundedDatePicker.show(context, theme: ThemeData.dark());
                              if (newDateTime != null) {
                                setState(() {
                                  dateTime = newDateTime;
                                });
                              }
                            },
                            label: Text("Rounded Calendar with Dark Theme")),
                        SizedBox(
                          height: 8,
                        ),
                        FloatingActionButton.extended(
                            onPressed: () async {
                              DateTime newDateTime = await RoundedDatePicker.show(context,
                                  theme: ThemeData(primarySwatch: Colors.blue),
                                  imageHeader: AssetImage("assets/images/calendar_header.jpg"),
                                  description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ");
                              if (newDateTime != null) {
                                setState(() {
                                  dateTime = newDateTime;
                                });
                              }
                            },
                            label: Text("Rounded Calendar and Image Header")),
                        SizedBox(
                          height: 8,
                        ),
                        FloatingActionButton.extended(
                            onPressed: () async {
                              DateTime newDateTime = await RoundedDatePicker.show(context,
                                  theme: ThemeData(primarySwatch: Colors.blue),
                                  imageHeader: AssetImage("assets/images/calendar_header_rainy.jpg"),
                                  fontFamily: "Mali",
                                  description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");
                              if (newDateTime != null) {
                                setState(() {
                                  dateTime = newDateTime;
                                });
                              }
                            },
                            label: Text("Rounded Calendar and Custom Font")),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Year Picker",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FloatingActionButton.extended(
                            onPressed: () async {
                              DateTime newDateTime = await RoundedDatePicker.show(context, initialDatePickerMode: DatePickerMode.year, theme: ThemeData(primarySwatch: Colors.green));
                              if (newDateTime != null) {
                                setState(() {
                                  dateTime = newDateTime;
                                });
                              }
                            },
                            label: Text("Rounded Year Picker")),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Cupertino Date Pciker ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FloatingActionButton.extended(
                            onPressed: () async {
                              DateTime newDateTime = await CupertinoRoundedDatePicker.show(context, fontFamily: "Mali");
                              if (newDateTime != null) {
                                setState(() {
                                  dateTime = newDateTime;
                                });
                              }
                            },
                            label: Text("Cupertino Rounded Date Picker")),
                        SizedBox(
                          height: 8,
                        ),
                        FloatingActionButton.extended(
                            onPressed: () {
                              CupertinoRoundedDatePicker.show(context,
                                  era: EraMode.BUDDHIST_YEAR,
                                  fontFamily: "Mali",
                                  textColor: Colors.white,
                                  background: Colors.red[300],
                                  borderRadius: 16,
                                  initialDatePickerMode: CupertinoDatePickerMode.date, onDateTimeChanged: (newDateTime) {
                                    setState(() {
                                      dateTime = newDateTime;
                                    });
                                  });
                            },
                            label: Text("Cupertino Rounded Date Picker with Theme")),
                        SizedBox(
                          height: 8,
                        ),
                        FloatingActionButton.extended(
                            onPressed: () async {
                              CupertinoRoundedDatePicker.show(context,
                                  initialDatePickerMode: CupertinoDatePickerMode.time,
                                  era: EraMode.BUDDHIST_YEAR,
                                  fontFamily: "Mali",
                                  textColor: Colors.white,
                                  background: Colors.green[300], onDateTimeChanged: (newDateTime) {
                                    setState(() {
                                      dateTime = newDateTime;
                                    });
                                  });
                            },
                            label: Text("Cupertino Rounded Time Picker")),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Cupertino Duration Picker ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FloatingActionButton.extended(
                            onPressed: () async {
                              CupertinoRoundedDurationPicker.show(context, initialTimerDuration: duration, initialDurationPickerMode: CupertinoTimerPickerMode.hms, fontFamily: "Mali",
                                  onDurationChanged: (newDuration) {
                                    setState(() {
                                      duration = newDuration;
                                    });
                                  });
                            },
                            label: Text("Cupertino Rounded Duration Picker")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
