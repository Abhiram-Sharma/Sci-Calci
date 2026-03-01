import 'package:flutter/material.dart';

/// Display panel showing the current expression and result
class DisplayPanel extends StatelessWidget {
  final String expression;
  final String result;

  const DisplayPanel({
    super.key,
    required this.expression,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1A1A),
            const Color(0xFF0F0F0F),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Current expression
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              expression,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w300,
                color: Colors.white.withValues(alpha: 0.9),
                letterSpacing: 1.5,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Result preview
          if (result.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                '= $result',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF6366F1),
                  letterSpacing: 1,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
