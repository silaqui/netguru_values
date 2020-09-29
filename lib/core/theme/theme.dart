import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Comfortaa',
      ),
    ),
  ),
  primarySwatch: primaryColor,
  fontFamily: 'Comfortaa',
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  accentColor: primaryColor,
  secondaryHeaderColor: Colors.grey.shade50,
  fontFamily: 'Comfortaa',
);

const MaterialColor primaryColor = MaterialColor(0xFF00D563, <int, Color>{
  50: Color(0xFFE0FAEC),
  100: Color(0xFFB3F2D0),
  200: Color(0xFF80EAB1),
  300: Color(0xFF4DE292),
  400: Color(0xFF26DB7A),
  500: Color(0xFF00D563),
  600: Color(0xFF00D05B),
  700: Color(0xFF00CA51),
  800: Color(0xFF00C447),
  900: Color(0xFF00BA35),
});
