import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';

/// Utility class for evaluating mathematical expressions
/// Handles PEMDAS, scientific functions, and error cases
class MathEvaluator {
  /// Evaluate a mathematical expression string
  /// Returns the result as a string or an error message
  static String evaluate(String expression, bool isDegreeMode) {
    try {
      // Handle empty expression
      if (expression.isEmpty || expression == '0') {
        return '0';
      }

      // Preprocess the expression
      String processedExpression =
          _preprocessExpression(expression, isDegreeMode);

      // Parse and evaluate using math_expressions library
      var parser = GrammarParser();
      Expression exp = parser.parse(processedExpression);

      ContextModel contextModel = ContextModel();

      // Add constants
      contextModel.bindVariable(Variable('π'), Number(math.pi));
      contextModel.bindVariable(Variable('e'), Number(math.e));

      double result = exp.evaluate(EvaluationType.REAL, contextModel);

      // Handle special cases
      if (result.isNaN) {
        return 'Math Error';
      }
      if (result.isInfinite) {
        return 'Infinity';
      }

      // Format the result
      return _formatResult(result);
    } catch (e) {
      // Handle specific error cases
      if (e.toString().contains('Division by zero')) {
        return 'Cannot divide by 0';
      }
      return 'Error';
    }
  }

  /// Preprocess expression to handle special functions and conversions
  static String _preprocessExpression(String expression, bool isDegreeMode) {
    String processed = expression;

    // Replace display symbols with parseable operators
    processed = processed.replaceAll('×', '*');
    processed = processed.replaceAll('÷', '/');
    processed = processed.replaceAll('π', '${math.pi}');
    processed = processed.replaceAll('e', '${math.e}');

    // Handle percentage (convert x% to x/100)
    processed = processed.replaceAllMapped(
      RegExp(r'(\d+\.?\d*)%'),
      (match) => '(${match.group(1)}/100)',
    );

    // Handle implicit multiplication (e.g., 2π becomes 2*π)
    processed = processed.replaceAllMapped(
      RegExp(r'(\d)([a-zA-Z(])'),
      (match) => '${match.group(1)}*${match.group(2)}',
    );

    // Convert trigonometric functions from degrees to radians if needed
    if (isDegreeMode) {
      processed = _convertTrigToDegrees(processed);
    }

    return processed;
  }

  /// Convert trigonometric functions to work with degrees
  static String _convertTrigToDegrees(String expression) {
    // Convert sin(x) to sin(x*π/180)
    expression = expression.replaceAllMapped(
      RegExp(r'sin\(([^)]+)\)'),
      (match) => 'sin((${match.group(1)})*${math.pi}/180)',
    );

    expression = expression.replaceAllMapped(
      RegExp(r'cos\(([^)]+)\)'),
      (match) => 'cos((${match.group(1)})*${math.pi}/180)',
    );

    expression = expression.replaceAllMapped(
      RegExp(r'tan\(([^)]+)\)'),
      (match) => 'tan((${match.group(1)})*${math.pi}/180)',
    );

    return expression;
  }

  /// Format the result for display
  static String _formatResult(double result) {
    // If the result is a whole number, display without decimals
    if (result == result.toInt()) {
      return result.toInt().toString();
    }

    // Round to 10 decimal places to avoid floating point errors
    String formatted = result.toStringAsFixed(10);

    // Remove trailing zeros
    formatted = formatted.replaceAll(RegExp(r'\.?0+$'), '');

    // Use scientific notation for very large or very small numbers
    if (result.abs() > 1e10 || (result.abs() < 1e-6 && result != 0)) {
      return result.toStringAsExponential(6).replaceAll(RegExp(r'\.?0+e'), 'e');
    }

    return formatted;
  }

  /// Calculate factorial
  static String factorial(String numberStr) {
    try {
      int number = int.parse(numberStr);

      if (number < 0) {
        return 'Error';
      }

      if (number > 170) {
        return 'Infinity'; // Factorial overflow
      }

      BigInt result = BigInt.one;
      for (int i = 2; i <= number; i++) {
        result *= BigInt.from(i);
      }

      return result.toString();
    } catch (e) {
      return 'Error';
    }
  }

  /// Calculate square root
  static String squareRoot(String numberStr) {
    try {
      double number = double.parse(numberStr);

      if (number < 0) {
        return 'Invalid Input';
      }

      double result = math.sqrt(number);
      return _formatResult(result);
    } catch (e) {
      return 'Error';
    }
  }

  /// Calculate cube root
  static String cubeRoot(String numberStr) {
    try {
      double number = double.parse(numberStr);
      double result = math.pow(number, 1 / 3).toDouble();
      return _formatResult(result);
    } catch (e) {
      return 'Error';
    }
  }

  /// Calculate power
  static String power(String base, String exponent) {
    try {
      double baseNum = double.parse(base);
      double expNum = double.parse(exponent);
      double result = math.pow(baseNum, expNum).toDouble();

      if (result.isNaN || result.isInfinite) {
        return 'Math Error';
      }

      return _formatResult(result);
    } catch (e) {
      return 'Error';
    }
  }
}
