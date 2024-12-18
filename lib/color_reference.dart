import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors 
  static const int _primaryValue = 0xFFB370FF;

  static const MaterialColor primarySwatch = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFF3E5FF), // Very light purple
      100: Color(0xFFE1BFFF), // Lighter purple
      200: Color(0xFFCD94FF), // Light purple
      300: Color(0xFFB370FF), // Your base color
      400: Color(0xFFA05EFF), // Slightly darker
      500: Color(_primaryValue), // Base color (primary)
      600: Color(0xFF9B53E6), // Darker
      700: Color(0xFF843CC4), // Even darker
      800: Color(0xFF6E27A3), // Dark purple
      900: Color(0xFF571182), // Deep dark purple
    },
  );

  //Secondairy Colors
  static const int _secondaryValue = 0xFF4510DE;

  static const MaterialColor secondarySwatch = MaterialColor(
    _secondaryValue,
    <int, Color>{
      50: Color(0xFFEDE6FB), // Very light violet
      100: Color(0xFFD1BEF5), // Lighter violet
      200: Color(0xFFB28DEF), // Light violet
      300: Color(0xFF935CEC), // Base tint
      400: Color(0xFF7A36E8), // Slightly darker tint
      500: Color(_secondaryValue), // Base color (primary shade)
      600: Color(0xFF3F0DCA), // Darker
      700: Color(0xFF370BAE), // Even darker
      800: Color(0xFF2F0893), // Dark violet
      900: Color(0xFF220666), // Deep dark violet
    },
  );
  static const Color primaryColor = Color(0xFFB370FF);
  static const Color secondaryColor = Color(0xFF4510DE); // purple (Secondary)
  
  // Background Colors
  static const Color backgroundColor = Color(0xFFF5F5F5); // Light Gray
  static const Color cardBackgroundColor = Color(0xFFFFFFFF); // White
  
  // Text Colors
  static const Color primaryTextColor = Color(0xFF000000); // Black
  static const Color secondaryTextColor = Color(0xFF616161); // Gray (Dark)
  static const Color disabledTextColor = Color(0xFF9E9E9E); // Gray (Light)
  static const Color errorTextColor = Color(0xFFB00020); // Red (Error)

  // Border Colors
  static const Color borderColor = Color(0xFFBDBDBD); // Gray (Border)

  // Icon Colors
  static const Color iconPrimaryColor = Color(0xFF424242); // Gray (Icons)
  static const Color iconSecondaryColor = Color(0xFF757575); // Light Gray (Icons)

  // Accent Colors
  static const Color successColor = Color(0xFF4CAF50); // Green
  static const Color warningColor = Color(0xFFFFC107); // Amber
  static const Color errorColor = Color(0xFFF44336); // Red
  static const Color infoColor = Color(0xFF2196F3); // Blue

  // Shades of Gray
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);

  // Transparent Colors
  static const Color transparent = Colors.transparent;

  // Gradients (example: for buttons or backgrounds)
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [Color(0xFF6200EA), Color(0xFF3700B3)], // Purple Gradient
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Other Utility Colors
  static const Color shadowColor = Color(0xFF000000); // Shadow with opacity
  static const Color overlayColor = Color(0x80000000); // Semi-transparent black
}
