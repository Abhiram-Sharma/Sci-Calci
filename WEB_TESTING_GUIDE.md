# Web Testing & GitHub Actions Guide

## 🌐 Testing on Web (Local)

### Prerequisites
- Flutter SDK installed
- Chrome or Edge browser

### Run Web Server
```bash
# Install dependencies first
flutter pub get

# Run on web server (default port 8080)
flutter run -d web-server

# Or specify a custom port
flutter run -d web-server --web-port=8080
```

### Access the App
Once running, open your browser to:
```
http://localhost:8080
```

### Web Compatibility Notes
✅ All dependencies are web-compatible:
- `provider` - Works on web
- `math_expressions` - Pure Dart, works on web
- `shared_preferences` - Uses browser localStorage on web

✅ No native-only plugins used
✅ No platform-specific code (removed SystemChrome orientation lock)
✅ Fully responsive UI works on desktop browsers

### Testing Checklist
- [ ] Basic arithmetic operations
- [ ] Scientific functions (sin, cos, tan, etc.)
- [ ] Memory operations (MC, MR, M+, M-)
- [ ] History drawer functionality
- [ ] DEG/RAD toggle
- [ ] Error handling (divide by zero, etc.)
- [ ] UI responsiveness
- [ ] History persistence (uses localStorage)

## 🤖 GitHub Actions - Remote APK Build

### Setup Instructions

1. **Push to GitHub**
   ```bash
   git init
   git add .
   git commit -m "Initial commit - Scientific Calculator"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
   git push -u origin main
   ```

2. **Automatic Build**
   - The workflow triggers automatically on push to `main` branch
   - No local Android SDK needed
   - Build runs on GitHub's servers

3. **Download APK**
   - Go to your repository on GitHub
   - Click "Actions" tab
   - Click on the latest workflow run
   - Scroll down to "Artifacts"
   - Download `calculator-release-apk`
   - Extract the ZIP to get `app-release.apk`

### Workflow Details

**File**: `.github/workflows/build.yml`

**Triggers**: Push to `main` branch

**Steps**:
1. Checkout code
2. Setup Java 17 (Zulu)
3. Setup Flutter (stable)
4. Install dependencies (`flutter pub get`)
5. Build release APK (`flutter build apk --release`)
6. Upload APK as artifact (30-day retention)

**Output**: `app-release.apk` ready for installation on Android devices

### Workflow Status
Check build status at:
```
https://github.com/YOUR_USERNAME/YOUR_REPO/actions
```

### Manual Trigger (Optional)
You can also trigger builds manually:
1. Go to Actions tab
2. Select "Build Android APK" workflow
3. Click "Run workflow"
4. Select branch and run

## 📱 Installing APK on Phone

### Method 1: Direct Download
1. Download APK from GitHub Actions artifacts
2. Transfer to phone via USB or cloud storage
3. Enable "Install from Unknown Sources" in phone settings
4. Open APK file and install

### Method 2: GitHub Release (Recommended)
1. Create a GitHub Release
2. Attach the APK file
3. Share the release link
4. Users can download directly on their phones

## 🔧 Troubleshooting

### Web Build Issues
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run -d web-server
```

### GitHub Actions Fails
- Check the Actions tab for error logs
- Ensure `pubspec.yaml` has correct dependencies
- Verify Flutter version compatibility

### APK Won't Install
- Enable "Install from Unknown Sources"
- Check Android version compatibility (minimum SDK 21)
- Ensure APK is not corrupted during download

## 🚀 Quick Commands

```bash
# Web testing
flutter pub get
flutter run -d web-server

# Check web compatibility
flutter build web --release

# Local APK build (if you have Android SDK)
flutter build apk --release

# Clean build
flutter clean
flutter pub get
```

## 📊 Build Artifacts

### Web Build Output
- Location: `build/web/`
- Can be deployed to any static hosting (Firebase, Netlify, etc.)

### Android APK Output
- Location: `build/app/outputs/flutter-apk/app-release.apk`
- Size: ~15-20 MB
- Minimum Android: 5.0 (API 21)

## 🎯 Next Steps

1. ✅ Test on web: `flutter run -d web-server`
2. ✅ Push to GitHub
3. ✅ Wait for Actions to build APK
4. ✅ Download and install on phone
5. ✅ Test all features on device

## 📝 Notes

- Web version uses browser localStorage for history
- Android version uses native SharedPreferences
- Both implementations are transparent to the user
- UI is fully responsive for both web and mobile
