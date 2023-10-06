import 'package:flutter/material.dart';

class AppTheme {
  final BuildContext context;

  const AppTheme(this.context);

  // static Size getSize(context) {
  //   return MediaQuery.of(context).size;
  // }

  // static const Map<int, Color> colorShades = {
  //   50: Color(0xFFE5E5E5),
  //   100: Color(0xFFCCCCCC),
  //   200: Color(0xFFB2B2B2),
  //   300: Color(0xFF999999),
  //   400: Color(0xFF808080),
  //   500: Color(0xFF565352),
  //   600: Color(0xFF4F4F4F),
  //   700: Color(0xFF1D1F23),
  //   800: Color(0xFF1A1A1A),
  //   900: Color(0xFF000000),
  // };

  // static const Map<int, Color> primaryColorShades = {
  //   50: Color(0xFFE0F2F1),
  //   100: Color(0xFFB2DFDB),
  //   200: Color(0xFF80CBC4),
  //   300: Color(0xFF4DB6AC),
  //   400: Color(0xFF26A69A),
  //   500: Color(0xFF01968C),
  //   600: Color(0xFF00897B),
  //   700: Color(0xFF00796B),
  //   800: Color(0xFF00695C),
  //   900: Color(0xFF004D40),
  // };

  // static const MaterialColor primarySwatch = MaterialColor(
  //   0xFF01968C,
  //   // 0xff222121,
  //   primaryColorShades,
  // );

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
        //backgroundColor: Colors.white,
        shadowColor: const Color(0x198d8d8d),
        primaryColor: Color(0xff1d1617),
        accentColor: Color.fromARGB(255, 184, 171, 36),
        // textTheme: TextTheme(
        //   button: Theme.of(context).textTheme.headline6,
        //   headline1: const TextStyle(
        //       fontSize: 96.0,
        //       fontWeight: FontWeight.w300,
        //       color: Colors.black,
        //       letterSpacing: -1.5),
        //   headline2: const TextStyle(
        //       fontSize: 60.0,
        //       fontWeight: FontWeight.w300,
        //       color: Colors.black,
        //       letterSpacing: -0.5),
        //   headline3: const TextStyle(
        //       fontSize: 48.0,
        //       fontWeight: FontWeight.w400,
        //       color: Colors.black,
        //       letterSpacing: 0.0),
        //   headline4: const TextStyle(
        //       fontSize: 34.0,
        //       fontWeight: FontWeight.w400,
        //       color: Colors.black,
        //       letterSpacing: 0.25),
        //   headline5: const TextStyle(
        //       fontSize: 24.0,
        //       fontWeight: FontWeight.w400,
        //       color: Colors.black,
        //       letterSpacing: 0.0),
        //   headline6: const TextStyle(
        //       fontSize: 20.0,
        //       fontWeight: FontWeight.w500,
        //       color: Color(0xff6d6d6d),
        //       letterSpacing: 0.15),
        //   bodyText1: const TextStyle(
        //       fontSize: 16.0,
        //       fontWeight: FontWeight.w400,
        //       letterSpacing: 0.5,
        //       color: Color(0xff6d6d6d)),
        //   bodyText2: const TextStyle(
        //       fontSize: 12.0,
        //       fontWeight: FontWeight.w400,
        //       letterSpacing: 0.25,
        //       color: Color(0xff6d6d6d)),
        // ),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
            Theme.of(context).textTheme.bodyText1!,
          ),
        )),
        dividerTheme: const DividerThemeData(
          color: Color(0xffa9a9a9),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Theme.of(context).primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        // appBarTheme: const AppBarTheme(
        //   foregroundColor: AppColors.secondaryBlack,
        //   elevation: 0,
        //   backgroundColor: AppColors.bg,

        //   // backgroundColor: AppColors.transparent,
        //   // surfaceTintColor: AppColors.primary,
        //   // systemOverlayStyle: SystemUiOverlayStyle(
        //   //   statusBarColor: AppColors.primary,
        //   //   statusBarBrightness: Brightness.light,
        //   //   statusBarIconBrightness: Brightness.dark,
        //   //   systemNavigationBarColor: AppColors.primary,
        //   //   systemNavigationBarDividerColor: AppColors.primary,
        //   //   systemNavigationBarIconBrightness: Brightness.dark,
        //   //   systemNavigationBarContrastEnforced: true,
        //   // ),
        // ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
            Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        )),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
              Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        scaffoldBackgroundColor: const Color(0xffFAFCFF),
        sliderTheme: const SliderThemeData(
          thumbColor: Colors.white,
          activeTrackColor: Colors.white,
          inactiveTrackColor: Colors.white,
        ),
        // iconTheme: const IconThemeData(color: Colors.white)
      );
}
