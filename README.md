# Scientific Calculator - Flutter App

A production-ready, industry-grade scientific calculator application for Android built with Flutter and Material Design 3.

## Features

### Core Functionality
- **Standard Arithmetic**: Addition, subtraction, multiplication, division, percentages
- **Scientific Functions**:
  - Trigonometry (sin, cos, tan) with DEG/RAD toggle
  - Logarithms (log base 10, ln)
  - Exponents and Roots (x², xʸ, √, ∛)
  - Constants (π, e)
  - Factorials (!)
- **Memory Operations**: MC, MR, M+, M-
- **Calculation History**: Persistent history with timestamps
- **Real-time Result Preview**: See results as you type
- **Error Handling**: Graceful handling of division by zero, invalid inputs, and math errors

### UI/UX
- Material Design 3 with dark mode
- High-contrast color scheme for operators vs numbers
- Responsive grid layout optimized for Android phones
- Smooth animations and transitions
- Pull-up history drawer
- Memory and angle mode indicators

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── models/
│   └── calculation_history.dart       # History data model
├── providers/
│   └── calculator_provider.dart       # State management (Provider pattern)
├── screens/
│   └── calculator_screen.dart         # Main calculator UI
├── utils/
│   └── math_evaluator.dart            # Math expression parser and evaluator
└── widgets/
    ├── calculator_button.dart         # Reusable button component
    ├── display_panel.dart             # Display area component
    └── history_drawer.dart            # History drawer component
```

## Tech Stack

- **Framework**: Flutter 3.0+
- **Language**: Dart
- **State Management**: Provider
- **Math Engine**: math_expressions (PEMDAS-compliant parser)
- **Persistence**: shared_preferences
- **Design**: Material Design 3

## Setup Instructions

### Prerequisites
- Flutter SDK 3.0 or higher
- Android Studio or VS Code with Flutter extensions
- Android device or emulator

### Installation

1. Clone or download this project

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Build for Release

To build an APK for distribution:
```bash
flutter build apk --release
```

To build an App Bundle for Google Play:
```bash
flutter build appbundle --release
```

## Code Architecture

### State Management (Provider Pattern)
The app uses the Provider pattern for state management. The `CalculatorProvider` class manages:
- Display state (expression and result)
- Calculator mode (degrees/radians)
- Memory operations
- Calculation history
- All calculator logic

### Math Evaluation
The `MathEvaluator` utility class handles:
- Expression preprocessing (converting display symbols to parseable operators)
- PEMDAS order of operations
- Trigonometric function conversion (degrees ↔ radians)
- Special functions (factorial, roots, powers)
- Error handling and result formatting

### UI Components
- **CalculatorButton**: Reusable button with Material Design 3 styling
- **DisplayPanel**: Shows current expression and real-time result preview
- **HistoryDrawer**: Bottom sheet displaying calculation history

## Key Features Explained

### Real-time Result Preview
As you type an expression, the calculator evaluates it in real-time and shows a preview of the result below the expression. This provides immediate feedback without needing to press equals.

### Angle Mode Toggle
The DEG/RAD toggle in the top-right switches between degrees and radians for trigonometric functions. The current mode is always visible.

### Memory Operations
- **MC**: Clear memory
- **MR**: Recall memory value
- **M+**: Add current value to memory
- **M-**: Subtract current value from memory

A small "M" indicator appears when memory contains a value.

### History Persistence
Calculation history is automatically saved using SharedPreferences and persists across app restarts. The history shows:
- Original expression
- Result
- Relative timestamp (e.g., "5m ago", "2h ago")

### Error Handling
The calculator gracefully handles:
- Division by zero → "Cannot divide by 0"
- Invalid mathematical operations → "Math Error"
- Invalid input → "Invalid Input"
- Factorial overflow → "Infinity"

## Color Scheme

The app uses a carefully designed color scheme for optimal readability:
- **Background**: Dark (#1A1A1A)
- **Display**: Darker (#0D0D0D)
- **Number buttons**: Dark gray (#2A2A2A)
- **Function buttons**: Medium gray (#3A3A3A) with primary color text
- **Operator buttons**: Primary color (deep purple)
- **Special buttons**: Secondary color

## Testing

To run tests (when implemented):
```bash
flutter test
```

## Performance Considerations

- Efficient state management with Provider
- Minimal rebuilds using Consumer widgets
- Optimized math evaluation with caching
- History limited to 50 most recent calculations
- Smooth 60fps animations

## Future Enhancements

Potential features for future versions:
- Landscape mode with extended scientific functions
- Customizable themes
- Export history to CSV
- Graph plotting
- Unit conversions
- Programmable functions

## License

This project is provided as-is for educational and commercial use.

## Support

For issues or questions, please refer to the inline code comments which extensively document the implementation details.
