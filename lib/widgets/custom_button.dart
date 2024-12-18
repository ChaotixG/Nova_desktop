import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text; // text is now optional (can be null)
  final VoidCallback onPressed;
  final Widget? icon; // Optional icon parameter

  const CustomButton({
    super.key,
    this.text, // Text is optional now
    required this.onPressed,
    this.icon, // Icon is also optional
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon!,
            if (text != null) const SizedBox(width: 8), // Add space between icon and text if both are present
          ],
          if (text != null) 
            Text(text!, style: const TextStyle(fontSize: 18)), // Display text only if provided
        ],
      ),
    );
  }
}
