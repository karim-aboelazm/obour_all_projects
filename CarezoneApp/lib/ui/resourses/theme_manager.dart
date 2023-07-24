import 'package:carezone/ui/resourses/styles_manager.dart';
import 'package:carezone/ui/resourses/values_manager.dart';
import 'package:flutter/material.dart';

import 'Color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // useMaterial3: true,

//main color
      primaryColor: ColorManager.primary,
      disabledColor: ColorManager.grey1,
      splashColor: ColorManager.lightPrimary,
      // ignore: deprecated_member_use
      backgroundColor: ColorManager.white,

//cardview theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),

//appbar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.white,
          elevation: AppSize.s4,
          shadowColor: ColorManager.lightPrimary,
          titleTextStyle: getRegularStyle(
              fontSize: FontSize.s16, color: ColorManager.white)),

//button theme

      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.primary,
          splashColor: ColorManager.lightPrimary),

//elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.primary,
            textStyle: getRegularStyle(
              color: ColorManager.white,
              fontSize: FontSize.s17,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s12),
            )),
      ),

      //text theme
      textTheme: TextTheme(
          displayLarge: getSemiBoldStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s16),
          headlineLarge: getSemiBoldStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s16),
          headlineMedium: getRegularStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s14),
          titleMedium: getMediumStyle(
              color: ColorManager.primary, fontSize: FontSize.s16),
          bodyLarge: getRegularStyle(color: ColorManager.grey1),
          bodySmall: getRegularStyle(color: ColorManager.grey)),

      //input decoration theme (text form field)
      inputDecorationTheme: InputDecorationTheme(
          //content padding
          contentPadding: const EdgeInsets.all(AppPadding.p8),
          //hint style
          hintStyle:
              getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
          //label style
          labelStyle:
              getMediumStyle(color: ColorManager.black, fontSize: FontSize.s24),
          //  errorStyle
          errorStyle: getRegularStyle(color: ColorManager.error),

          //error border style
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.error),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),
          // focused error style
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.primary),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),

          //focused border style
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.grey),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),
          // enabled Border style
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.primary),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8)))));
}
