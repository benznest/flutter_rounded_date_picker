# Flutter Rounded Date Picker
Select the date with rounded date picker.


## Installing
Add dependencies in pubspec.yaml file.

```
dependencies:
  flutter_localizations:
    sdk: flutter
  flutter_rounded_date_picker: 0.1.0
```

## Initialize localizations
Add localization delegates in MaterialApp Widget.
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

## Importing
import package into your dart.
```
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/rounded_date_picker.dart';
```

## Show Date Picker
Show date picker
```
DateTime newDateTime = await RoundedDatePicker.show(context,
                            initialDate: DateTime.now(), 
                            firstDate: DateTime(DateTime.now().year - 1), 
                            lastDate: DateTime(DateTime.now().year + 1), 
                            borderRadius: 16);
```
![Screenshot](screenshots/1.png)
![Screenshot](screenshots/a1.gif)

## Theme
initialize theme in date picker.
```
DateTime newDateTime = await RoundedDatePicker.show(context, theme: ThemeData(primarySwatch: Colors.pink));
```
![Screenshot](screenshots/2.png)

Dark theme
```
DateTime newDateTime = await RoundedDatePicker.show(context, theme: ThemeData.dark());
```
![Screenshot](screenshots/3.png)


## Image Header 
use image background on header also you can add description.
```
DateTime newDateTime = await RoundedDatePicker.show(context,
                            theme: ThemeData(primarySwatch: Colors.blue),
                            imageHeader: AssetImage("assets/images/calendar_header.jpg"),
                            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ");
```
![Screenshot](screenshots/4.png)

## Custom Font in Date Picker 
use image background on header also you can add description.
```
                        DateTime newDateTime = await RoundedDatePicker.show(context,
                             fontFamily: "Mali");
```
![Screenshot](screenshots/5.png)