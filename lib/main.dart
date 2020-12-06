import 'package:flutter/material.dart';
import 'package:flutter_ui_challenge_clock/color.dart';
import 'package:flutter_ui_challenge_clock/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock App',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'SourceSansPro',
        textTheme: TextTheme(
          headline1: TextStyle(
            color: accentColor,
            fontSize: 90,
            height: 1,
            fontWeight: FontWeight.w600,
          ),
          headline3: TextStyle(
            color: accentColor,
            fontSize: 40,
            fontWeight: FontWeight.w600,
          ),
          headline4: TextStyle(
            color: accentColor,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
          headline6: TextStyle(
            color: accentColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          subtitle1: TextStyle(
            color: accentColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          button: TextStyle(
            fontWeight: FontWeight.w700,
            color: accentColor,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
