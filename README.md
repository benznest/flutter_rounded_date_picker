# Flutter Rounded Date Picker
The Flutter plugin that help you can choose dates and years with rounded calendars and customizable themes.


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