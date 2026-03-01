import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scientific_calculator/main.dart';

void main() {
  testWidgets('Calculator smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ScientificCalculatorApp());
    expect(find.text('Scientific Calculator'), findsOneWidget);
  });
}
