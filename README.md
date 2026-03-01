# Scientific Calculator

A modern, production-ready scientific calculator built with Flutter. Features a sleek Material Design 3 interface with full web and Android support.

## Features

- **Standard Operations**: Addition, subtraction, multiplication, division, percentages
- **Scientific Functions**: Trigonometry (sin, cos, tan), logarithms (log, ln), powers, roots, factorials
- **Memory Operations**: MC, MR, M+, M-
- **Calculation History**: Persistent history with timestamps
- **DEG/RAD Toggle**: Switch between degrees and radians
- **Real-time Preview**: See results as you type
- **Error Handling**: Graceful error messages, no crashes

## Quick Start

### Web
```bash
flutter pub get
flutter run -d chrome
```

### Android
```bash
flutter build apk --release
```

## Tech Stack

- Flutter 3.0+
- Provider (State Management)
- math_expressions (Math Engine)
- Material Design 3

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/                      # Data models
├── providers/                   # State management
├── screens/                     # UI screens
├── utils/                       # Business logic
└── widgets/                     # Reusable components
```

## License

MIT License - Feel free to use this project for learning or commercial purposes.
