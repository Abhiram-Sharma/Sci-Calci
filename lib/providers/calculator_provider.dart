import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/calculation_history.dart';
import '../utils/math_evaluator.dart';

/// Main state management provider for the calculator
/// Handles all calculator logic, state, and persistence
class CalculatorProvider extends ChangeNotifier {
  // Display state
  String _displayExpression = '0';
  String _displayResult = '';
  
  // Calculator state
  bool _isDegreeMode = true; // true = Degrees, false = Radians
  bool _shouldResetOnNextInput = false;
  
  // Memory state
  double _memory = 0.0;
  
  // History state
  List<CalculationHistory> _history = [];
  
  // Getters
  String get displayExpression => _displayExpression;
  String get displayResult => _displayResult;
  bool get isDegreeMode => _isDegreeMode;
  bool get hasMemory => _memory != 0.0;
  List<CalculationHistory> get history => List.unmodifiable(_history);

  CalculatorProvider() {
    _loadHistory();
  }

  /// Handle number button press
  void onNumberPressed(String number) {
    if (_shouldResetOnNextInput) {
      _displayExpression = number;
      _displayResult = '';
      _shouldResetOnNextInput = false;
    } else {
      if (_displayExpression == '0') {
        _displayExpression = number;
      } else {
        _displayExpression += number;
      }
    }
    _updateResult();
    notifyListeners();
  }

  /// Handle operator button press
  void onOperatorPressed(String operator) {
    if (_shouldResetOnNextInput) {
      _shouldResetOnNextInput = false;
    }
    
    // Prevent multiple operators in a row
    if (_displayExpression.isNotEmpty) {
      String lastChar = _displayExpression[_displayExpression.length - 1];
      if ('+-×÷'.contains(lastChar)) {
        _displayExpression = _displayExpression.substring(0, _displayExpression.length - 1);
      }
    }
    
    _displayExpression += operator;
    _displayResult = '';
    notifyListeners();
  }

  /// Handle decimal point
  void onDecimalPressed() {
    if (_shouldResetOnNextInput) {
      _displayExpression = '0.';
      _shouldResetOnNextInput = false;
    } else {
      // Check if current number already has a decimal
      List<String> parts = _displayExpression.split(RegExp(r'[+\-×÷]'));
      String lastNumber = parts.isNotEmpty ? parts.last : '';
      
      if (!lastNumber.contains('.')) {
        if (_displayExpression.isEmpty || '+-×÷'.contains(_displayExpression[_displayExpression.length - 1])) {
          _displayExpression += '0.';
        } else {
          _displayExpression += '.';
        }
      }
    }
    notifyListeners();
  }

  /// Handle equals button
  void onEqualsPressed() {
    if (_displayExpression.isEmpty || _displayExpression == '0') {
      return;
    }

    String result = MathEvaluator.evaluate(_displayExpression, _isDegreeMode);
    
    // Add to history if valid calculation
    if (result != 'Error' && result != 'Math Error' && result != 'Invalid Input') {
      _addToHistory(_displayExpression, result);
    }
    
    _displayResult = result;
    _shouldResetOnNextInput = true;
    notifyListeners();
  }

  /// Handle clear button (AC)
  void onClearPressed() {
    _displayExpression = '0';
    _displayResult = '';
    _shouldResetOnNextInput = false;
    notifyListeners();
  }

  /// Handle backspace/delete
  void onBackspacePressed() {
    if (_shouldResetOnNextInput) {
      onClearPressed();
      return;
    }
    
    if (_displayExpression.isNotEmpty && _displayExpression != '0') {
      _displayExpression = _displayExpression.substring(0, _displayExpression.length - 1);
      if (_displayExpression.isEmpty) {
        _displayExpression = '0';
      }
      _updateResult();
    }
    notifyListeners();
  }

  /// Handle parentheses
  void onParenthesisPressed(String parenthesis) {
    if (_shouldResetOnNextInput && parenthesis == '(') {
      _displayExpression = parenthesis;
      _shouldResetOnNextInput = false;
    } else {
      _displayExpression += parenthesis;
    }
    _updateResult();
    notifyListeners();
  }

  /// Handle scientific functions
  void onFunctionPressed(String function) {
    String currentValue = _displayResult.isNotEmpty ? _displayResult : _displayExpression;
    
    switch (function) {
      case 'sin':
      case 'cos':
      case 'tan':
        _displayExpression = '$function($currentValue)';
        break;
      case 'ln':
        _displayExpression = 'ln($currentValue)';
        break;
      case 'log':
        _displayExpression = 'log($currentValue)';
        break;
      case '√':
        String result = MathEvaluator.squareRoot(currentValue);
        _displayExpression = result;
        _displayResult = '';
        _shouldResetOnNextInput = true;
        notifyListeners();
        return;
      case '∛':
        String result = MathEvaluator.cubeRoot(currentValue);
        _displayExpression = result;
        _displayResult = '';
        _shouldResetOnNextInput = true;
        notifyListeners();
        return;
      case 'x²':
        _displayExpression = '($currentValue)^2';
        break;
      case 'xʸ':
        _displayExpression = '$currentValue^';
        notifyListeners();
        return;
      case '!':
        String result = MathEvaluator.factorial(currentValue);
        _displayExpression = result;
        _displayResult = '';
        _shouldResetOnNextInput = true;
        notifyListeners();
        return;
    }
    
    _updateResult();
    notifyListeners();
  }

  /// Handle constants
  void onConstantPressed(String constant) {
    if (_shouldResetOnNextInput) {
      _displayExpression = constant;
      _shouldResetOnNextInput = false;
    } else {
      if (_displayExpression == '0') {
        _displayExpression = constant;
      } else {
        _displayExpression += constant;
      }
    }
    _updateResult();
    notifyListeners();
  }

  /// Toggle between Degrees and Radians
  void toggleAngleMode() {
    _isDegreeMode = !_isDegreeMode;
    _updateResult();
    notifyListeners();
  }

  /// Memory Clear
  void onMemoryClear() {
    _memory = 0.0;
    notifyListeners();
  }

  /// Memory Recall
  void onMemoryRecall() {
    _displayExpression = _memory.toString();
    _displayResult = '';
    _shouldResetOnNextInput = true;
    notifyListeners();
  }

  /// Memory Add
  void onMemoryAdd() {
    String valueToAdd = _displayResult.isNotEmpty ? _displayResult : _displayExpression;
    try {
      _memory += double.parse(valueToAdd);
      notifyListeners();
    } catch (e) {
      // Invalid number, do nothing
    }
  }

  /// Memory Subtract
  void onMemorySubtract() {
    String valueToSubtract = _displayResult.isNotEmpty ? _displayResult : _displayExpression;
    try {
      _memory -= double.parse(valueToSubtract);
      notifyListeners();
    } catch (e) {
      // Invalid number, do nothing
    }
  }

  /// Update result in real-time as user types
  void _updateResult() {
    if (_displayExpression.isEmpty || _displayExpression == '0') {
      _displayResult = '';
      return;
    }

    // Don't evaluate if expression ends with an operator
    String lastChar = _displayExpression[_displayExpression.length - 1];
    if ('+-×÷^('.contains(lastChar)) {
      _displayResult = '';
      return;
    }

    String result = MathEvaluator.evaluate(_displayExpression, _isDegreeMode);
    
    // Only show result if it's different from expression and valid
    if (result != 'Error' && result != _displayExpression) {
      _displayResult = result;
    } else {
      _displayResult = '';
    }
  }

  /// Add calculation to history
  void _addToHistory(String expression, String result) {
    _history.insert(
      0,
      CalculationHistory(
        expression: expression,
        result: result,
        timestamp: DateTime.now(),
      ),
    );
    
    // Keep only last 50 entries
    if (_history.length > 50) {
      _history = _history.sublist(0, 50);
    }
    
    _saveHistory();
  }

  /// Clear all history
  void clearHistory() {
    _history.clear();
    _saveHistory();
    notifyListeners();
  }

  /// Load history from persistent storage
  Future<void> _loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? historyJson = prefs.getString('calculation_history');
      
      if (historyJson != null) {
        final List<dynamic> decoded = json.decode(historyJson);
        _history = decoded
            .map((item) => CalculationHistory.fromJson(item as Map<String, dynamic>))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading history: $e');
    }
  }

  /// Save history to persistent storage
  Future<void> _saveHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String historyJson = json.encode(
        _history.map((item) => item.toJson()).toList(),
      );
      await prefs.setString('calculation_history', historyJson);
    } catch (e) {
      debugPrint('Error saving history: $e');
    }
  }

  /// Use a history item
  void useHistoryItem(CalculationHistory item) {
    _displayExpression = item.result;
    _displayResult = '';
    _shouldResetOnNextInput = true;
    notifyListeners();
  }
}
