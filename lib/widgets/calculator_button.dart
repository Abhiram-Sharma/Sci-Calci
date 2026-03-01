import 'package:flutter/material.dart';

/// Custom calculator button widget with professional styling
class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final bool isWide;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(20),
      elevation: 0,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.white.withValues(alpha: 0.1),
        highlightColor: Colors.white.withValues(alpha: 0.05),
        child: Container(
          width: isWide ? double.infinity : null,
          height: 68,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize ?? 22,
              fontWeight: FontWeight.w500,
              color: textColor ?? Colors.white.withValues(alpha: 0.9),
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

/// Button type enum for different button categories
enum ButtonType {
  number,
  operator,
  function,
  special,
}

/// Get button color based on type
Color getButtonColor(BuildContext context, ButtonType type) {
  switch (type) {
    case ButtonType.number:
      return const Color(0xFF1E1E1E);
    case ButtonType.operator:
      return const Color(0xFF6366F1);
    case ButtonType.function:
      return const Color(0xFF2A2A2A);
    case ButtonType.special:
      return const Color(0xFF3B3B3B);
  }
}

/// Get text color based on button type
Color getTextColor(BuildContext context, ButtonType type) {
  switch (type) {
    case ButtonType.number:
      return Colors.white.withValues(alpha: 0.95);
    case ButtonType.operator:
      return Colors.white;
    case ButtonType.function:
      return const Color(0xFF6366F1);
    case ButtonType.special:
      return const Color(0xFFEF4444);
  }
}
