import 'package:flutter/material.dart';

/// Custom calculator button widget with Material Design 3 styling
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
    final theme = Theme.of(context);

    return Material(
      color: backgroundColor ?? theme.colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: isWide ? double.infinity : null,
          height: 64,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize ?? 24,
              fontWeight: FontWeight.w500,
              color: textColor ?? theme.colorScheme.onSurfaceVariant,
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
  final theme = Theme.of(context);

  switch (type) {
    case ButtonType.number:
      return const Color(0xFF2A2A2A);
    case ButtonType.operator:
      return theme.colorScheme.primary;
    case ButtonType.function:
      return const Color(0xFF3A3A3A);
    case ButtonType.special:
      return theme.colorScheme.secondary;
  }
}

/// Get text color based on button type
Color getTextColor(BuildContext context, ButtonType type) {
  final theme = Theme.of(context);

  switch (type) {
    case ButtonType.number:
      return Colors.white;
    case ButtonType.operator:
      return theme.colorScheme.onPrimary;
    case ButtonType.function:
      return theme.colorScheme.primary;
    case ButtonType.special:
      return theme.colorScheme.onSecondary;
  }
}
