import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0xFF282828),
    secondary: Color(0xffFFFCFC),
    onSecondary: Color(0xFFC6C6C6),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.black,
    disabledActionTextColor: Colors.white,
    contentTextStyle: TextStyle(fontSize: 14, color: Colors.white),
  ),
  scaffoldBackgroundColor: Color(0xff181818),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff181818),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Color(0xffFFFCFC),
    ),
    centerTitle: false,
    iconTheme: IconThemeData(color: Color(0xffffffff)),
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
 textButtonTheme: TextButtonThemeData(
  style: ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Color(0xffffffff))
  )

 ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xffFFFCFC),
    extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Color(0xffffffff),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: Color(0xffffffff),
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      color: Color(0xffffffff),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xffFFFCFC),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: Color(0xffC6C6C6),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
      color: Color(0xffA0A0A0),
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFFA0A0A0),
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
      color: Color(0xffFFFCFC),
      decoration: TextDecoration.none,
    ),
    bodyMedium: TextStyle(
      fontSize: 20,
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
      color: Color(0xffFFFCFC),
      decoration: TextDecoration.none,
    ),
    labelMedium: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(fontSize: 16, color: Color(0xFF6D6D6D)),
    filled: true,
    fillColor: Color(0xFF282828),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    side: BorderSide(color: Color(0xFF6E6E6E), width: 2),
  ),
  iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
  dividerTheme: DividerThemeData(color: Color(0xFFCAC4D0)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Color(0xFF15B86C),
    selectionHandleColor: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color(0xff181818),
    selectedItemColor: Color(0xff15B86C),
    unselectedItemColor: Color(0xFFC6C6C6),
    selectedLabelStyle: TextStyle(fontSize: 14, color: Color(0xFF15B86C)),
    unselectedLabelStyle: TextStyle(fontSize: 14, color: Color(0xFFC6C6C6)),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    elevation: 4,
    shadowColor: Color(0xff15B86C),
    color: Color(0xff181818),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Color(0xff15B86C), width: 1),
      borderRadius: BorderRadius.circular(16),
    ),
  ),
);
