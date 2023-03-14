import 'package:flutter/material.dart';
import 'package:my_souaq/app/styles/colors.dart';

ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: Declarations.backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: Declarations.secondaryColor,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
    ));
