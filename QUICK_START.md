# Quick Start Guide

## Get Running in 3 Steps

### Step 1: Install Dependencies
```bash
flutter pub get
```

### Step 2: Run the App
```bash
flutter run
```

### Step 3: Start Calculating!
The app will launch on your connected device or emulator.

## First Time Setup

### Prerequisites
Make sure you have:
- Flutter SDK installed ([Get Flutter](https://flutter.dev/docs/get-started/install))
- Android Studio or VS Code with Flutter extension
- An Android device or emulator running

### Verify Flutter Installation
```bash
flutter doctor
```

This command checks your environment and displays a report. Fix any issues it identifies.

## Building for Release

### Create APK
```bash
flutter build apk --release
```
The APK will be at: `build/app/outputs/flutter-apk/app-release.apk`

### Create App Bundle (for Google Play)
```bash
flutter build appbundle --release
```
The bundle will be at: `build/app/outputs/bundle/release/app-release.aab`

## Using the Calculator

### Basic Operations
- Tap numbers and operators to build expressions
- Tap `=` to calculate
- Tap `AC` to clear

### Scientific Functions
- Use `sin`, `cos`, `tan` for trigonometry
- Toggle `DEG`/`RAD` for angle mode
- Use `√` for square root, `x²` for square
- Use `log` and `ln` for logarithms

### Memory
- `MC`: Clear memory
- `MR`: Recall memory
- `M+`: Add to memory
- `M-`: Subtract from memory

### History
- Tap the history icon (top right)
- Tap any calculation to reuse it
- Tap "Clear All" to delete history

## Troubleshooting

### "No devices found"
- Start an Android emulator, or
- Connect an Android device with USB debugging enabled

### "Gradle build failed"
```bash
flutter clean
flutter pub get
flutter run
```

### "Package not found"
Make sure you ran `flutter pub get` first

## Project Structure Overview

```
lib/
├── main.dart              # Start here
├── models/                # Data structures
├── providers/             # State management
├── screens/               # UI screens
├── utils/                 # Business logic
└── widgets/               # Reusable components
```

## Key Files to Understand

1. **main.dart** - App entry point and theme setup
2. **calculator_provider.dart** - All calculator logic and state
3. **math_evaluator.dart** - Math expression evaluation
4. **calculator_screen.dart** - Main UI layout

## Need More Info?

- Full documentation: `README.md`
- Project structure: `PROJECT_STRUCTURE.md`
- Requirements checklist: `DELIVERABLES.md`

## Common Commands

```bash
# Run in debug mode
flutter run

# Run in release mode
flutter run --release

# Hot reload (press 'r' in terminal while app is running)
# Hot restart (press 'R' in terminal)

# Check for issues
flutter analyze

# Format code
flutter format lib/

# Clean build files
flutter clean
```

## Tips

- The app auto-saves history
- Real-time results appear as you type
- Long-press buttons for additional functions (future feature)
- Swipe down to dismiss history drawer

Enjoy your scientific calculator! 🧮
