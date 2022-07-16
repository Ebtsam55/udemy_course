import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black26,
    textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.white)),
    appBarTheme: const AppBarTheme(
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black26,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black26,
            statusBarBrightness: Brightness.light)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black26,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey),
    dividerColor: Colors.white);

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.black)),
    appBarTheme: const AppBarTheme(
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.dark)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.deepOrange, unselectedItemColor: Colors.grey),
    dividerColor: Colors.black);
