import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xFFFFFFFF),
    secondary: Color(0xff161F1B),
    onSecondary: Color(0xFF3A4640),
  ),
  scaffoldBackgroundColor: Color(0xFFF6F7F9),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xffF6F7F9),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Color(0xff161F1B),
    ),
    centerTitle: false,
    iconTheme: IconThemeData(color: Color(0xff161F1B)),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF15B86C);
      }
      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Color(0xFF9e9e9e);
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0xFF9e9e9e);
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 2;
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xFF15B86C)),
      foregroundColor: WidgetStateProperty.all(Color(0xffFFFCFC)),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xffFFFCFC),
    extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),

  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: Color(0xff3A4640),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      fontSize: 14,
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
      color: Color(0xff6A6A6A),
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFF49454F),
    ),
    bodyLarge: TextStyle(
      fontSize: 14,
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
      color: Color(0xff161F1B),
      decoration: TextDecoration.none,
    ),
    bodyMedium: TextStyle(
      fontSize: 20,
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
      color: Color(0xff161F1B),
      decoration: TextDecoration.none,
    ),
    labelMedium: TextStyle(fontSize: 20, color: Color(0xFF161F1B)),
  ),

  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(fontSize: 16, color: Color(0xFF9E9E9E)),
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    side: BorderSide(color: Color(0xFFD1DAD6), width: 2),
  ),
  iconTheme: IconThemeData(color: Color(0xff161F1B)),
  dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6)),

  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Color(0xff000000),
    selectionColor: Color(0xFF15B86C),
    selectionHandleColor: Color(0xff000000),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color(0xffF6F7F9),
    selectedItemColor: Color(0xff14A662),
    unselectedItemColor: Color(0xFF3A4640),
    selectedLabelStyle: TextStyle(fontSize: 14, color: Color(0xFF14A662)),
    unselectedLabelStyle: TextStyle(fontSize: 14, color: Color(0xFF3A4640)),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.black)),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    elevation: 4,
    shadowColor: Color(0xff15B86C),
    color: Color(0xFFF6F7F9),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Color(0xff15B86C), width: 1),
      borderRadius: BorderRadius.circular(16),
    ),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
    ),
  ),
);
