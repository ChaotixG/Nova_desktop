import 'package:flutter/material.dart';

class AppColors {
  // Primary and Secondary Colors
  static const Color primaryColor = Color(0xFF6200EA); // Deep Purple (Primary)
  static const Color secondaryColor = Color(0xFF03DAC5); // Teal (Secondary)
  
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
