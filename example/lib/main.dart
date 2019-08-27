import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/thai_date_picker.dart';

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
          const Locale('th', 'TH'), // Thai
        ],
        home: Builder(builder: (context) {
          return Scaffold(
//        appBar: AppBar(
//          title: Text('Plugin example app'),
//        ),
            body: Center(
              child: Text("$dateTime",style: TextStyle(fontSize: 20),),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  dateTime = await ThaiDatePicker.show(context);
                  setState(() {
                    //
                  });
                },
                label: Text("Open Calendar")),
          );
        }));
  }
}
