# Flutter Rounded Date Picker

The Flutter plugin that help you can choose dates and years with rounded calendars and customizable themes.

![Screenshot](screenshots/a2.gif)
![Screenshot](screenshots/a3.gif)
![Screenshot](screenshots/a4.gif)
![Screenshot](screenshots/a5.gif)

## Installing

Add dependencies in pubspec.yaml file. Add 2 things in it including flutter_localizations

```dart
dependencies:
  flutter_localizations:
    sdk: flutter
  flutter_rounded_date_picker: 0.3.0
```

## Importing

import packages into your dart.

```dart
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
```

## Initialize localizations

Add localization delegates in MaterialApp Widget and add languages that your app supports.

```dart
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
)
```

## Show Date Picker

Show date picker which you can specify a date that allows users to choose.

```dart
DateTime newDateTime = await showRoundedDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(DateTime.now().year - 1),
  lastDate: DateTime(DateTime.now().year + 1),
  borderRadius: 16,
),
```

![Screenshot](screenshots/1.png)
![Screenshot](screenshots/a1.gif)

## Show Year Picker

Show year picker which you can specify a year start and end that allows users to choose.

```dart
DateTime newDateTime = await showRoundedDatePicker(
  context: context,
  initialDatePickerMode: DatePickerMode.year,
  theme: ThemeData(primarySwatch: Colors.green),
);
```

![Screenshot](screenshots/8.png)

## Theme

You can assign themes to the date picker by using ThemeData class and PrimarySwatch.

```dart
DateTime newDateTime = await showRoundedDatePicker(
  context: context,
  theme: ThemeData(primarySwatch: Colors.pink),
);
```

![Screenshot](screenshots/2.png)

Dark theme

```dart
DateTime newDateTime = await showRoundedDatePicker(
  context: context,
  theme: ThemeData.dark(),
);
```

![Screenshot](screenshots/3.png)

Custom Theme with ThemeData

```dart
DateTime newDateTime = await showRoundedDatePicker(
  context: context,
  background: Colors.white,
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
      body2 : TextStyle(color: Colors.green[200]),
    ),
  ),
);
```

![Screenshot](screenshots/9.png)

## Image Background Header

Use images as the header of the date picker and you can also add more details.

* You need to specify the path of images in your asset (pubspec.yaml).

```dart
DateTime newDateTime = await showRoundedDatePicker(
  context: context,
  theme: ThemeData(primarySwatch: Colors.blue),
  imageHeader: AssetImage("assets/images/calendar_header.jpg"),
  description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
);
```

![Screenshot](screenshots/4.png)

## Customize Font in Date Picker

You can adjust the Font-family in the date picker.

* You need to specify the path of font in your fonts (pubspec.yaml).

```dart
DateTime newDateTime = await showRoundedDatePicker(
  context: context,
  fontFamily: "Mali"
);
```

![Screenshot](screenshots/5.png)

## Date Picker Locale

You can set the date picker locale. By specifying the language code and country code.
As of April 2019, this package supports about 52 languages.

```dart
DateTime newDateTime = await showRoundedDatePicker(
  context: context,
  locale: Locale("zh","CN"),
  theme: ThemeData(primarySwatch: Colors.pink),
);
```

![Screenshot](screenshots/6.png)

## Thai and Buddhist Year

If you are using Thai language And use the Buddhist era (543 BCE). Plugins that support these capabilities.

```dart
DateTime newDateTime = await showRoundedDatePicker(
  context: context,
  locale: Locale("th", "TH"),
  era: EraMode.BUDDHIST_YEAR,
);
```

![Screenshot](screenshots/7.png)

## Show Time Picker

Show time picker, all feature of date picker is available (except description)

```dart
final timePicked = await showRoundedTimePicker(
  context: context,
  initialTime: TimeOfDay.now(),
);
```

![Screenshot](screenshots/17.png)

# Cupertino Date Picker

Show date and duration picker iOS style.

## Installing

Add Flutter Cupertino Localizations in dependencies pub.yaml.

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  flutter_cupertino_localizations: 1.0.1
```

## Initialize localizations

Add CupertinoLocalizations delegate to localizations delegate on your App.
The cupertino date picker will use current app locale in picker.

```dart
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
)
```

## Show Cupertino Date Picker

Call the method for displaying date picker.
The callback date time instance will be return with onDateTimeChange.

```dart
CupertinoRoundedDatePicker.show(
  context,
  fontFamily: "Mali",
  textColor: Colors.white,
  background: Colors.red[300],
  borderRadius: 16,
  initialDatePickerMode: CupertinoDatePickerMode.date,
  onDateTimeChanged: (newDateTime) {
    //
  },
);
```

![Screenshot](screenshots/12.png)

More Cupertino Date Picker Mode

```dart
CupertinoDatePickerMode.date
CupertinoDatePickerMode.dateAndTime
CupertinoDatePickerMode.time
```

![Screenshot](screenshots/10.png)
![Screenshot](screenshots/11.png)

using Thai and Buddhist Year

```dart
/// Current locale is TH.
CupertinoRoundedDatePicker.show(
  context,
  fontFamily: "Mali",
  textColor: Colors.white,
  era: EraMode.BUDDHIST_YEAR,
  background: Colors.red[300],
  borderRadius: 16,
  initialDatePickerMode: CupertinoDatePickerMode.date,
  onDateTimeChanged: (newDateTime) {
    //
  },
);
```

![Screenshot](screenshots/13.png)

## Cupertino Duration Picker

in iOS , Flutter cupertino support duration and timer picker.

```dart
CupertinoRoundedDurationPicker.show(
  context,
  initialTimerDuration: Duration(minute:10),
  initialDurationPickerMode: CupertinoTimerPickerMode.hms,
  fontFamily: "Mali",
  onDurationChanged: (newDuration) {
    //
  },
);
```

![Screenshot](screenshots/14.png)

More Cupertino Duration Picker Mode

```dart
CupertinoTimerPickerMode.hms
CupertinoTimerPickerMode.hm
CupertinoTimerPickerMode.ms
```

![Screenshot](screenshots/15.png)
![Screenshot](screenshots/16.png)
