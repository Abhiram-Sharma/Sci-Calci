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
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D),
        borderRadius: BorderRadius.circular(20),
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
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Result preview
          if (result.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                '= $result',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
