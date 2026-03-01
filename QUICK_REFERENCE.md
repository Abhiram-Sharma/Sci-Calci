# 🚀 Quick Reference Card

## 🌐 Test on Web NOW

### Your app is starting on:
```
http://localhost:8081
```

Open this URL in your browser (Chrome, Edge, Firefox, etc.)

### If port 8081 doesn't work, try:
```bash
flutter run -d web-server --web-port=8082
```

## 📱 Get Android APK

### Option 1: GitHub Actions (Recommended - No Android SDK needed)
```bash
# 1. Push to GitHub
git init
git add .
git commit -m "Scientific Calculator"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin main

# 2. Wait 5-10 minutes for build

# 3. Download APK
# Go to: https://github.com/YOUR_USERNAME/YOUR_REPO/actions
# Click latest run → Scroll to Artifacts → Download "calculator-release-apk"
```

### Option 2: Local Build (If you have Android SDK)
```bash
flutter build apk --release
# APK location: build/app/outputs/flutter-apk/app-release.apk
```

## 🎮 Calculator Features

### Basic Operations
- **Numbers**: 0-9
- **Operators**: + - × ÷
- **Decimal**: .
- **Parentheses**: ( )
- **Percentage**: %
- **Clear**: AC
- **Equals**: =

### Scientific Functions
- **Trig**: sin, cos, tan
- **Logs**: log (base 10), ln (natural)
- **Powers**: x² (square), xʸ (power)
- **Roots**: √ (square root), ∛ (cube root)
- **Constants**: π (pi), e (Euler)
- **Factorial**: ! (use after number)

### Memory
- **MC**: Clear memory
- **MR**: Recall memory value
- **M+**: Add current value to memory
- **M-**: Subtract from memory
- **Indicator**: [M] shows when memory has value

### Modes
- **DEG/RAD**: Toggle between degrees and radians
- Tap the indicator to switch

### History
- **Icon**: Top-right corner (≡)
- **View**: Tap to see all calculations
- **Reuse**: Tap any calculation to use result
- **Clear**: "Clear All" button

## 🧪 Test Cases

### Try These:
```
2+2                    → 4
10÷2                   → 5
(2+3)×4                → 20
sin(30)                → 0.5 (in DEG mode)
log(100)               → 2
√16                    → 4
2^3                    → 8
5!                     → 120
π×2                    → 6.28...
1÷0                    → Cannot divide by 0
```

## 🐛 Troubleshooting

### Web Server Won't Start
```bash
# Try different port
flutter run -d web-server --web-port=8082

# Or clean and retry
flutter clean
flutter pub get
flutter run -d web-server
```

### Browser Shows Blank Page
- Wait for compilation to complete
- Check terminal for "Serving at http://..."
- Refresh browser
- Try incognito/private mode

### GitHub Actions Build Fails
- Check Actions tab for error logs
- Ensure all files are committed
- Verify pubspec.yaml syntax

## 📋 File Checklist

✅ **pubspec.yaml** - Dependencies
✅ **lib/main.dart** - Entry point
✅ **lib/providers/calculator_provider.dart** - Logic
✅ **lib/screens/calculator_screen.dart** - UI
✅ **lib/utils/math_evaluator.dart** - Math engine
✅ **lib/widgets/** - UI components
✅ **.github/workflows/build.yml** - CI/CD
✅ **web/** - Web support

## 🎯 Quick Commands

```bash
# Install dependencies
flutter pub get

# Run on web
flutter run -d web-server --web-port=8081

# Build web
flutter build web --release

# Check code
flutter analyze

# Clean
flutter clean

# Check devices
flutter devices
```

## 📊 Build Status

### Web Build: ✅ Ready
```bash
flutter build web --release
# Status: Successful
```

### Code Quality: ✅ Clean
```bash
flutter analyze
# Result: No issues found!
```

### Dependencies: ✅ Installed
```bash
flutter pub get
# Status: Got dependencies!
```

## 🎨 Color Scheme

- **Background**: Dark (#1A1A1A)
- **Display**: Darker (#0D0D0D)
- **Numbers**: Dark Gray (#2A2A2A)
- **Functions**: Medium Gray (#3A3A3A)
- **Operators**: Deep Purple (Primary)
- **Special**: Secondary Color

## 💡 Tips

- **Real-time Results**: See answer as you type
- **History Persists**: Survives page refresh
- **Error Messages**: Clear, no crashes
- **Responsive**: Works on any screen size
- **Dark Mode**: Easy on the eyes

## 📞 Support

### Documentation
- `README.md` - Full documentation
- `WEB_TESTING_GUIDE.md` - Web testing
- `DEPLOYMENT_GUIDE.md` - Deployment steps
- `FINAL_SUMMARY.md` - Complete summary

### Common Issues
1. **Port in use**: Try different port
2. **Build fails**: Run `flutter clean`
3. **APK won't install**: Enable unknown sources

---

**Your app is running at**: http://localhost:8081

**Open in browser and start calculating!** 🧮✨
