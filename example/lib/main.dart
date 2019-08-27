import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/rounded_date_picker.dart';
import 'package:flutter_rounded_date_picker/era_mode.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime dateTime;

  @override
  void initState() {
    dateTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
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
              child: ListView(
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
                        ],
                      ),
                    ),
                  ),
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
                      label: Text("Material English Calendar")),
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
                      label: Text("Rounded English Calendar")),
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
                      label: Text("Rounded Thai Calendar")),
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
                ],
              ),
            ),
          );
        }));
  }
}
