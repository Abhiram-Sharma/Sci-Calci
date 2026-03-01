import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../widgets/calculator_button.dart';
import '../widgets/display_panel.dart';
import '../widgets/history_drawer.dart';

/// Main calculator screen with scientific functions
class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific Calculator'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // History button
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) => const HistoryDrawer(),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Display panel
              Consumer<CalculatorProvider>(
                builder: (context, provider, child) {
                  return DisplayPanel(
                    expression: provider.displayExpression,
                    result: provider.displayResult,
                  );
                },
              ),
              const SizedBox(height: 16),
              // Memory and mode indicators
              Consumer<CalculatorProvider>(
                builder: (context, provider, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Memory indicator
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: provider.hasMemory
                              ? Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          provider.hasMemory ? 'M' : '',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Angle mode toggle
                      InkWell(
                        onTap: provider.toggleAngleMode,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            provider.isDegreeMode ? 'DEG' : 'RAD',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              // Button grid
              Expanded(
                child: _buildButtonGrid(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build the calculator button grid
  Widget _buildButtonGrid(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context, listen: false);

    return Column(
      children: [
        // Row 1: Scientific functions
        Expanded(
          child: Row(
            children: [
              _buildButton(context, 'sin', ButtonType.function,
                  () => provider.onFunctionPressed('sin')),
              _buildButton(context, 'cos', ButtonType.function,
                  () => provider.onFunctionPressed('cos')),
              _buildButton(context, 'tan', ButtonType.function,
                  () => provider.onFunctionPressed('tan')),
              _buildButton(context, 'ln', ButtonType.function,
                  () => provider.onFunctionPressed('ln')),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Row 2: More scientific functions
        Expanded(
          child: Row(
            children: [
              _buildButton(context, 'log', ButtonType.function,
                  () => provider.onFunctionPressed('log')),
              _buildButton(context, '√', ButtonType.function,
                  () => provider.onFunctionPressed('√')),
              _buildButton(context, 'x²', ButtonType.function,
                  () => provider.onFunctionPressed('x²')),
              _buildButton(context, 'xʸ', ButtonType.function,
                  () => provider.onFunctionPressed('xʸ')),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Row 3: Memory and special functions
        Expanded(
          child: Row(
            children: [
              _buildButton(
                  context, 'MC', ButtonType.special, provider.onMemoryClear),
              _buildButton(
                  context, 'MR', ButtonType.special, provider.onMemoryRecall),
              _buildButton(
                  context, 'M+', ButtonType.special, provider.onMemoryAdd),
              _buildButton(
                  context, 'M-', ButtonType.special, provider.onMemorySubtract),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Row 4: Clear, parentheses, operators
        Expanded(
          child: Row(
            children: [
              _buildButton(
                  context, 'AC', ButtonType.special, provider.onClearPressed),
              _buildButton(context, '(', ButtonType.function,
                  () => provider.onParenthesisPressed('(')),
              _buildButton(context, ')', ButtonType.function,
                  () => provider.onParenthesisPressed(')')),
              _buildButton(context, '÷', ButtonType.operator,
                  () => provider.onOperatorPressed('÷')),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Row 5: Numbers 7-9 and multiply
        Expanded(
          child: Row(
            children: [
              _buildButton(context, '7', ButtonType.number,
                  () => provider.onNumberPressed('7')),
              _buildButton(context, '8', ButtonType.number,
                  () => provider.onNumberPressed('8')),
              _buildButton(context, '9', ButtonType.number,
                  () => provider.onNumberPressed('9')),
              _buildButton(context, '×', ButtonType.operator,
                  () => provider.onOperatorPressed('×')),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Row 6: Numbers 4-6 and subtract
        Expanded(
          child: Row(
            children: [
              _buildButton(context, '4', ButtonType.number,
                  () => provider.onNumberPressed('4')),
              _buildButton(context, '5', ButtonType.number,
                  () => provider.onNumberPressed('5')),
              _buildButton(context, '6', ButtonType.number,
                  () => provider.onNumberPressed('6')),
              _buildButton(context, '-', ButtonType.operator,
                  () => provider.onOperatorPressed('-')),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Row 7: Numbers 1-3 and add
        Expanded(
          child: Row(
            children: [
              _buildButton(context, '1', ButtonType.number,
                  () => provider.onNumberPressed('1')),
              _buildButton(context, '2', ButtonType.number,
                  () => provider.onNumberPressed('2')),
              _buildButton(context, '3', ButtonType.number,
                  () => provider.onNumberPressed('3')),
              _buildButton(context, '+', ButtonType.operator,
                  () => provider.onOperatorPressed('+')),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Row 8: Special buttons and equals
        Expanded(
          child: Row(
            children: [
              _buildButton(context, 'π', ButtonType.function,
                  () => provider.onConstantPressed('π')),
              _buildButton(context, '0', ButtonType.number,
                  () => provider.onNumberPressed('0')),
              _buildButton(
                  context, '.', ButtonType.number, provider.onDecimalPressed),
              _buildButton(
                  context, '=', ButtonType.operator, provider.onEqualsPressed),
            ],
          ),
        ),
      ],
    );
  }

  /// Helper method to build a button with consistent styling
  Widget _buildButton(
    BuildContext context,
    String text,
    ButtonType type,
    VoidCallback onPressed,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: CalculatorButton(
          text: text,
          onPressed: onPressed,
          backgroundColor: getButtonColor(context, type),
          textColor: getTextColor(context, type),
          fontSize: _getButtonFontSize(text),
        ),
      ),
    );
  }

  /// Get appropriate font size based on button text length
  double _getButtonFontSize(String text) {
    if (text.length > 2) {
      return 18;
    }
    return 24;
  }
}
