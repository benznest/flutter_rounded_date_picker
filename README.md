# Flutter Rounded Date Picker
The Flutter plugin that help you can choose dates and years with rounded calendars and customizable themes.

![Screenshot](screenshots/a2.gif)
![Screenshot](screenshots/a3.gif)
![Screenshot](screenshots/a4.gif)
![Screenshot](screenshots/a5.gif)

## Installing
Add dependencies in pubspec.yaml file. Add 2 things in it including flutter_localizations

```
dependencies:
  flutter_localizations:
    sdk: flutter
  flutter_rounded_date_picker: 0.1.0
```

## Importing
import packages into your dart.
```
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/rounded_date_picker.dart';
```

## Initialize localizations
Add localization delegates in MaterialApp Widget and add languages that your app supports.
```
MaterialApp(
    localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
          const Locale('en', 'US'), // English
          const Locale('th', 'TH'), // Thai
    ],
    ...
```

## Show Date Picker
Show date picker which you can specify a date that allows users to choose.
```
DateTime newDateTime = await RoundedDatePicker.show(context,
                            initialDate: DateTime.now(), 
                            firstDate: DateTime(DateTime.now().year - 1), 
                            lastDate: DateTime(DateTime.now().year + 1), 
                            borderRadius: 16);
```
![Screenshot](screenshots/1.png)
![Screenshot](screenshots/a1.gif)

## Show Year Picker
Show year picker which you can specify a year start and end that allows users to choose.
```
DateTime newDateTime = await RoundedDatePicker.show(context, 
                                    initialDatePickerMode: DatePickerMode.year, 
                                    theme: ThemeData(primarySwatch: Colors.green));
```
![Screenshot](screenshots/8.png)

## Theme
You can assign themes to the date picker by using ThemeData class and PrimarySwatch.
```
DateTime newDateTime = await RoundedDatePicker.show(context, theme: ThemeData(primarySwatch: Colors.pink));
```
![Screenshot](screenshots/2.png)

Dark theme
```
DateTime newDateTime = await RoundedDatePicker.show(context, theme: ThemeData.dark());
```
![Screenshot](screenshots/3.png)

Custom Theme with ThemeData
```
DateTime newDateTime = await RoundedDatePicker.show(context,background: Colors.white,
                            theme: ThemeData(
                                primaryColor: Colors.red[400],
                                accentColor: Colors.green[800],
                                dialogBackgroundColor: Colors.purple[50],
                                textTheme: TextTheme(
                                    body1: TextStyle(color: Colors.red), 
                                    caption: TextStyle(color: Colors.blue)),
                                    disabledColor: Colors.orange, 
                                accentTextTheme: TextTheme(
                                    body2 : TextStyle(color: Colors.green[200]))));
```
![Screenshot](screenshots/9.png)

## Image Background Header 
Use images as the header of the date picker and you can also add more details.
* You need to specify the path of images in your asset (pubspec.yaml).
```
DateTime newDateTime = await RoundedDatePicker.show(context,
                            theme: ThemeData(primarySwatch: Colors.blue),
                            imageHeader: AssetImage("assets/images/calendar_header.jpg"),
                            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ");
```
![Screenshot](screenshots/4.png)

## Customize Font in Date Picker 
You can adjust the Font-family in the date picker.
* You need to specify the path of font in your fonts (pubspec.yaml).
```
DateTime newDateTime = await RoundedDatePicker.show(context,fontFamily: "Mali");
```
![Screenshot](screenshots/5.png)

## Date Picker Locale
You can set the date picker locale. By specifying the language code and country code.
As of April 2019, this package supports about 52 languages.
```
DateTime newDateTime = await RoundedDatePicker.show(context,
                                        locale: Locale("zh","CN"),
                                        theme: ThemeData(primarySwatch: Colors.pink));
```
![Screenshot](screenshots/6.png)

## Thai and Buddhist Year
If you are using Thai language And use the Buddhist era (543 BCE). Plugins that support these capabilities.
```
DateTime newDateTime = await RoundedDatePicker.show(context, 
                                    locale: Locale("th", "TH"), 
                                    era: EraMode.BUDDHIST_YEAR);
```
![Screenshot](screenshots/7.png)



# Cupertino Date Picker
Show date and duration picker iOS style.


## Installing 
Add Flutter Cupertini Localizations in dependencies.
```
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  flutter_cupertino_localizations: 1.0.1   
```

## Initialize localizations
Add CupertinoLocalizations delegate to localizations delegate on your App.
```
MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,  // Add global cupertino localiztions.
        ],
        locale: Locale('en', 'US'),  // Current locale
        supportedLocales: [
          const Locale('en', 'US'), // English
          const Locale('th', 'TH'), // Thai
        ],
```

## Show Cupertino Date Picker
Call the method for displaying date picker. 
The callback date time instance will be return with onDateTimeChange.
```
CupertinoRoundedDatePicker.show(context, 
                                  fontFamily: "Mali",
                                  textColor: Colors.white, 
                                  background: Colors.red[300],
                                  borderRadius: 16,
                                  initialDatePickerMode: CupertinoDatePickerMode.date,
                                  onDateTimeChanged: (newDateTime) {
                                    //
                                  });
```
![Screenshot](screenshots/12.png)

More Cupertino Date Picker Mode
```
CupertinoDatePickerMode.date
CupertinoDatePickerMode.dateAndTime
CupertinoDatePickerMode.time
```
![Screenshot](screenshots/10.png)
![Screenshot](screenshots/11.png)


using Thai and Buddhist Year 
```
/// Current locale is TH.
CupertinoRoundedDatePicker.show(context, 
                                  fontFamily: "Mali",
                                  textColor: Colors.white, 
                                  era: EraMode.BUDDHIST_YEAR,
                                  background: Colors.red[300],
                                  borderRadius: 16,
                                  initialDatePickerMode: CupertinoDatePickerMode.date,
                                  onDateTimeChanged: (newDateTime) {
                                    //
                                  });
```
![Screenshot](screenshots/13.png)


## Cupertino Duration Picker
in iOS , Flutter cupertino support duration and timer picker.
```
CupertinoRoundedDurationPicker.show(context, 
                                initialTimerDuration: Duration(minute:10), 
                                initialDurationPickerMode: CupertinoTimerPickerMode.hms, 
                                fontFamily: "Mali",
                                onDurationChanged: (newDuration) {
                                    //
                                });
 ```
![Screenshot](screenshots/14.png)

More Cupertino Duration Picker Mode
```
CupertinoTimerPickerMode.hms
CupertinoTimerPickerMode.hm
CupertinoTimerPickerMode.ms
```
![Screenshot](screenshots/15.png)
![Screenshot](screenshots/16.png)