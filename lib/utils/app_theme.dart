import 'package:flutter/material.dart';
import 'package:fyp/utils/app_colors.dart';

class AppTheme {
  static Color secondaryGrey = const Color(0xff6D6D6D);
  static Color buttonColor = const Color(0xff1D1929);

  ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xffA9A9A9),
          backgroundColor: const Color(0xffFFFFFF),
          brightness: Brightness.light,
          errorColor: const Color(0xffFF3737),
          cardColor: Colors.white,
        ),
        shadowColor: const Color(0x198d8d8d),
        primaryColor: const Color(0xff1d1617),
        accentColor: Color.fromARGB(255, 184, 171, 36),
        dividerTheme: const DividerThemeData(
          color: Color(0xffa9a9a9),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.primaryColor,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.primaryColor),
          titleTextStyle: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          // textStyle: MaterialStateProperty.all<TextStyle>(
          //   Theme.of(context)
          //       .textTheme
          //       .bodyMedium!
          //       .copyWith(fontWeight: FontWeight.bold),
          // ),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        )),
        cardTheme: CardTheme(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        scaffoldBackgroundColor: const Color(0xffFAFAFA),
        sliderTheme: const SliderThemeData(
          thumbColor: AppColors.primaryColor,
          activeTrackColor: Colors.white,
          inactiveTrackColor: Colors.white,
        ),
        // iconTheme: const IconThemeData(color: Colors.white)
      );
}
