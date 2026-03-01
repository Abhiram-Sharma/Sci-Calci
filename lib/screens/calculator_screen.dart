import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../widgets/calculator_button.dart';
import '../widgets/display_panel.dart';
import '../widgets/history_drawer.dart';

/// Main calculator screen with professional UI
class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: const Text(
          'Scientific Calculator',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded, size: 26),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) => const HistoryDrawer(),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Consumer<CalculatorProvider>(
                builder: (context, provider, child) {
                  return DisplayPanel(
                    expression: provider.displayExpression,
                    result: provider.displayResult,
                  );
                },
              ),
              const SizedBox(height: 20),
              Consumer<CalculatorProvider>(
                builder: (context, provider, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: provider.hasMemory
                              ? const Color(0xFF6366F1).withValues(alpha: 0.15)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: provider.hasMemory
                                ? const Color(0xFF6366F1).withValues(alpha: 0.3)
                                : Colors.transparent,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          provider.hasMemory ? 'M' : '',
                          style: const TextStyle(
                            color: Color(0xFF6366F1),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: provider.toggleAngleMode,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF6366F1).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF6366F1)
                                  .withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            provider.isDegreeMode ? 'DEG' : 'RAD',
                            style: const TextStyle(
                              color: Color(0xFF6366F1),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _buildButtonGrid(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonGrid(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context, listen: false);

    return Column(
      children: [
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
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
        Expanded(
          child: Row(
            children: [
              _buildButton(
                  context, 'MC', ButtonType.function, provider.onMemoryClear),
              _buildButton(
                  context, 'MR', ButtonType.function, provider.onMemoryRecall),
              _buildButton(
                  context, 'M+', ButtonType.function, provider.onMemoryAdd),
              _buildButton(context, 'M-', ButtonType.function,
                  provider.onMemorySubtract),
            ],
          ),
        ),
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
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

  Widget _buildButton(
    BuildContext context,
    String text,
    ButtonType type,
    VoidCallback onPressed,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
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

  double _getButtonFontSize(String text) {
    if (text.length > 2) {
      return 18;
    }
    return 22;
  }
}
