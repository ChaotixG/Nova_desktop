import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text; // Optional text
  final VoidCallback onPressed;
  final Widget? icon; // Optional icon
  final Widget? animationOrGif; // Optional animation or GIF
  final OutlinedBorder? shape; // Corrected type to match ElevatedButton's requirement

  const CustomButton({
    super.key,
    this.text,
    required this.onPressed,
    this.icon,
    this.animationOrGif,
    this.shape, // Custom shape
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: shape ?? RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (animationOrGif != null) ...[
            animationOrGif!,
            if (text != null || icon != null) const SizedBox(width: 8),
          ],
          if (icon != null) ...[
            icon!,
            if (text != null) const SizedBox(width: 8),
          ],
          if (text != null)
            Text(
              text!,
              style: const TextStyle(fontSize: 18),
            ),
        ],
      ),
    );
  }
}
