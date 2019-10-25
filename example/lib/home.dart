import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

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
                          body1: TextStyle(color: Colors.red),
                          caption: TextStyle(color: Colors.blue),
                        ),
                        disabledColor: Colors.orange,
                        accentTextTheme: TextTheme(
                          body2: TextStyle(color: Colors.green[200]),
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
                      negativeBtn: "CUSTOM CANCEL",
                      positiveBtn: "CUSTOM OK",
                      leftBtn: "TODAY",
                      onLeftBtn: () {
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
                    DateTime newDateTime =
                        await CupertinoRoundedDatePicker.show(
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
