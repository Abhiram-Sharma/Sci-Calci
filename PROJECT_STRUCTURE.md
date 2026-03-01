# Scientific Calculator - Complete Project Structure

## Directory Tree

```
scientific_calculator/
├── lib/
│   ├── main.dart                          # Application entry point
│   ├── models/
│   │   └── calculation_history.dart       # Data model for history entries
│   ├── providers/
│   │   └── calculator_provider.dart       # State management provider
│   ├── screens/
│   │   └── calculator_screen.dart         # Main calculator screen
│   ├── utils/
│   │   └── math_evaluator.dart            # Math expression evaluator
│   └── widgets/
│       ├── calculator_button.dart         # Custom button widget
│       ├── display_panel.dart             # Display area widget
│       └── history_drawer.dart            # History drawer widget
├── pubspec.yaml                           # Dependencies configuration
├── analysis_options.yaml                  # Linting rules
├── README.md                              # Project documentation
└── PROJECT_STRUCTURE.md                   # This file

```

## File Descriptions

### Core Files

#### `lib/main.dart`
- Application entry point
- Configures Material Design 3 theme
- Sets up Provider for state management
- Locks orientation to portrait mode
- Initializes the app with dark theme

#### `pubspec.yaml`
- Defines project metadata
- Lists all dependencies:
  - `provider`: State management
  - `math_expressions`: Math parsing and evaluation
  - `shared_preferences`: History persistence
  - `material_color_utilities`: Material Design 3 colors

### Models

#### `lib/models/calculation_history.dart`
- Defines the `CalculationHistory` class
- Properties:
  - `expression`: The mathematical expression
  - `result`: The calculated result
  - `timestamp`: When the calculation was performed
- Includes JSON serialization for persistence

### Providers (State Management)

#### `lib/providers/calculator_provider.dart`
- Central state management class using ChangeNotifier
- Manages:
  - Display state (expression and result)
  - Calculator mode (degrees/radians)
  - Memory operations (MC, MR, M+, M-)
  - Calculation history
  - Input handling and validation
- Key methods:
  - `onNumberPressed()`: Handle number input
  - `onOperatorPressed()`: Handle operator input
  - `onEqualsPressed()`: Evaluate expression
  - `onFunctionPressed()`: Handle scientific functions
  - `toggleAngleMode()`: Switch between DEG/RAD
  - Memory operations: `onMemoryClear()`, `onMemoryRecall()`, etc.
  - History management: `_addToHistory()`, `clearHistory()`, etc.

### Screens

#### `lib/screens/calculator_screen.dart`
- Main UI screen
- Builds the calculator layout:
  - App bar with history button
  - Display panel
  - Memory and mode indicators
  - 8-row button grid
- Button grid includes:
  - Row 1: sin, cos, tan, ln
  - Row 2: log, √, x², xʸ
  - Row 3: MC, MR, M+, M-
  - Row 4: AC, (, ), ÷
  - Row 5: 7, 8, 9, ×
  - Row 6: 4, 5, 6, -
  - Row 7: 1, 2, 3, +
  - Row 8: π, 0, ., =

### Utils

#### `lib/utils/math_evaluator.dart`
- Core mathematical evaluation logic
- Key functions:
  - `evaluate()`: Main evaluation function
  - `_preprocessExpression()`: Converts display symbols to parseable format
  - `_convertTrigToDegrees()`: Handles degree/radian conversion
  - `_formatResult()`: Formats numbers for display
  - `factorial()`: Calculates factorials
  - `squareRoot()`: Calculates square roots
  - `cubeRoot()`: Calculates cube roots
  - `power()`: Calculates powers
- Handles:
  - PEMDAS order of operations
  - Trigonometric functions
  - Logarithms
  - Constants (π, e)
  - Error cases (division by zero, invalid input, etc.)

### Widgets

#### `lib/widgets/calculator_button.dart`
- Reusable button component
- Features:
  - Material Design 3 styling
  - Customizable colors and sizes
  - Ripple effect on tap
  - Support for wide buttons
- Includes helper functions:
  - `getButtonColor()`: Returns color based on button type
  - `getTextColor()`: Returns text color based on button type
- Button types:
  - Number buttons (dark gray)
  - Operator buttons (primary color)
  - Function buttons (medium gray)
  - Special buttons (secondary color)

#### `lib/widgets/display_panel.dart`
- Display area showing expression and result
- Features:
  - Dark background for contrast
  - Horizontal scrolling for long expressions
  - Two-line display:
    - Top: Current expression (white)
    - Bottom: Real-time result preview (primary color)
  - Rounded corners
  - Proper padding and spacing

#### `lib/widgets/history_drawer.dart`
- Bottom sheet showing calculation history
- Features:
  - Pull-up handle bar
  - Header with "Clear All" button
  - Scrollable list of history items
  - Empty state message
  - Tap to use a history item
- Each history item shows:
  - Original expression
  - Result
  - Relative timestamp (e.g., "5m ago")

## Data Flow

1. **User Input** → Button press in `calculator_screen.dart`
2. **State Update** → Method called in `calculator_provider.dart`
3. **Evaluation** → Expression evaluated by `math_evaluator.dart`
4. **UI Update** → Provider notifies listeners, UI rebuilds
5. **Persistence** → History saved to SharedPreferences

## State Management Flow

```
User Action
    ↓
CalculatorButton (Widget)
    ↓
CalculatorProvider (State)
    ↓
MathEvaluator (Logic)
    ↓
CalculatorProvider (Update State)
    ↓
notifyListeners()
    ↓
Consumer<CalculatorProvider> (Rebuild)
    ↓
Updated UI
```

## Key Design Decisions

### Why Provider?
- Simple and efficient for single-page app
- Built-in to Flutter ecosystem
- Easy to understand and maintain
- Minimal boilerplate

### Why math_expressions?
- Robust PEMDAS implementation
- Handles complex expressions
- Well-tested library
- Supports scientific functions

### Why Material Design 3?
- Modern, professional appearance
- Consistent with Android design language
- Built-in accessibility features
- Smooth animations and transitions

### Color Scheme Rationale
- Dark theme reduces eye strain
- High contrast improves readability
- Color-coded buttons help users quickly identify function types
- Primary color (purple) draws attention to operators and results

## Performance Optimizations

1. **Selective Rebuilds**: Using `Consumer` widgets to rebuild only necessary parts
2. **Efficient Evaluation**: Real-time evaluation only when expression is valid
3. **History Limiting**: Maximum 50 entries to prevent memory issues
4. **Lazy Loading**: History loaded asynchronously on app start
5. **Minimal State**: Only essential state stored in provider

## Error Handling Strategy

1. **Input Validation**: Prevent invalid input at the UI level
2. **Graceful Degradation**: Show error messages instead of crashing
3. **Try-Catch Blocks**: Wrap all evaluation logic
4. **User-Friendly Messages**: Clear error messages for users
5. **State Recovery**: Calculator remains functional after errors

## Testing Strategy (Future Implementation)

### Unit Tests
- `math_evaluator.dart`: Test all mathematical operations
- `calculator_provider.dart`: Test state management logic
- `calculation_history.dart`: Test JSON serialization

### Widget Tests
- Button interactions
- Display updates
- History drawer functionality

### Integration Tests
- Complete calculation flows
- Memory operations
- History persistence

## Build Configuration

### Debug Build
```bash
flutter run
```

### Release Build (APK)
```bash
flutter build apk --release
```

### Release Build (App Bundle)
```bash
flutter build appbundle --release
```

## Dependencies Version Management

All dependencies use caret syntax (^) for automatic minor/patch updates:
- `provider: ^6.1.1` - Will update to 6.x.x but not 7.0.0
- `math_expressions: ^2.4.0` - Will update to 2.x.x but not 3.0.0
- `shared_preferences: ^2.2.2` - Will update to 2.x.x but not 3.0.0

## Future Scalability

The architecture supports easy addition of:
- New scientific functions (add to `math_evaluator.dart`)
- New button layouts (modify `calculator_screen.dart`)
- Themes (add to `main.dart`)
- Additional screens (add to `screens/` directory)
- More complex state (extend `calculator_provider.dart`)
