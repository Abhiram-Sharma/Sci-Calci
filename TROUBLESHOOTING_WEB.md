# 🔧 Web Troubleshooting Guide

## Issue: Blank Screen on Web

### Solution 1: Use Edge/Chrome Instead of Web Server

The web-server device sometimes has issues. Use a real browser instead:

```bash
# Stop current process (Ctrl+C)

# Run on Edge
flutter run -d edge

# Or run on Chrome (if installed)
flutter run -d chrome
```

This will automatically open the browser with your app.

### Solution 2: Clear Browser Cache

1. Open browser DevTools (F12)
2. Go to Application/Storage tab
3. Click "Clear site data"
4. Refresh page (Ctrl+F5)

### Solution 3: Check Browser Console

1. Open DevTools (F12)
2. Go to Console tab
3. Look for any error messages
4. Common errors:
   - "Failed to load" → Compilation still in progress
   - "404 Not Found" → Server not ready yet
   - JavaScript errors → Check code issues

### Solution 4: Rebuild from Scratch

```bash
# Stop the server
# Press Ctrl+C in terminal

# Clean everything
flutter clean

# Get dependencies
flutter pub get

# Run on Edge
flutter run -d edge
```

### Solution 5: Check if Server is Actually Running

Look for this message in terminal:
```
lib\main.dart is being served at http://localhost:XXXX
```

If you don't see this, the compilation is still in progress.

### Solution 6: Try Different Port

```bash
flutter run -d web-server --web-port=9000
```

Then open: `http://localhost:9000`

### Solution 7: Use Release Build

Debug builds can be slow. Try release:

```bash
# Build release version
flutter build web --release

# Serve the build folder
cd build/web
python -m http.server 8000

# Open: http://localhost:8000
```

## Current Status

Your app is currently compiling for Edge browser. This takes 1-2 minutes on first run.

**What's happening:**
1. ✅ Dependencies installed
2. ✅ Code analyzed (no errors)
3. 🔄 Compiling for web...
4. ⏳ Waiting for Edge to open...

**When ready, you'll see:**
- Edge browser opens automatically
- Calculator app loads
- Terminal shows "Application finished"

## Quick Checks

### Is Flutter Working?
```bash
flutter doctor
```

### Are Dependencies Installed?
```bash
flutter pub get
```

### Is Code Valid?
```bash
flutter analyze
```

### What Devices Available?
```bash
flutter devices
```

## Alternative: Build and Test Manually

If live reload isn't working, build manually:

```bash
# Build web version
flutter build web --release

# Output will be in: build/web/

# Open build/web/index.html in browser
# Or use a local server
```

## Expected Behavior

When working correctly:
1. Run `flutter run -d edge`
2. Wait 1-2 minutes for compilation
3. Edge opens automatically
4. Calculator app appears
5. All features work

## Common Issues

### "No connected devices"
- Install Chrome or Edge
- Run `flutter devices` to verify

### "Failed to bind"
- Port already in use
- Try different port or device

### "Compilation error"
- Run `flutter clean`
- Run `flutter pub get`
- Try again

### "White screen"
- Wait for compilation to complete
- Check browser console for errors
- Try hard refresh (Ctrl+Shift+R)

## Debug Mode vs Release Mode

**Debug Mode** (current):
- Slower
- Larger file size
- Hot reload enabled
- Better error messages

**Release Mode**:
- Faster
- Smaller file size
- Optimized
- Production-ready

To use release mode:
```bash
flutter run -d edge --release
```

## Next Steps

1. **Wait for Edge to open** (currently compiling)
2. **If blank screen persists:**
   - Check browser console (F12)
   - Try hard refresh (Ctrl+Shift+R)
   - Try incognito mode
3. **If still not working:**
   - Stop process (Ctrl+C)
   - Run: `flutter clean && flutter pub get`
   - Run: `flutter run -d edge`

## Success Indicators

✅ Terminal shows "Application finished"
✅ Edge browser opens
✅ Calculator UI visible
✅ Buttons respond to clicks
✅ Calculations work

Your app is currently compiling. Edge should open automatically when ready! 🚀
