import 'package:flutter/material.dart';
import 'package:kemet/core/colors.dart';

//TODO: refactor the  light mode
ThemeData appLightTheme(){
  return ThemeData(

    appBarTheme:const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold
        )
    ),

    primaryColor: AppColors.primary,
    hintColor: AppColors.hint,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    //fontFamily: AppStrings.fontFamily,
    textTheme: TextTheme(
      button: TextStyle(
        fontSize: 16,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
      ),
    ),

  );
}

//TODO: refactor the  dark mode
ThemeData appDarkTheme(){
  return ThemeData(
    appBarTheme:const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold
        )
    ),
    primaryColor: AppColors.primary,
    hintColor: AppColors.hint,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    //fontFamily: AppStrings.fontFamily,
    textTheme:const TextTheme(
      button: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    ),

  );
}