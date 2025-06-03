#!/bin/bash

echo "=== Flutter Multiplatform Setup Check ==="
echo ""

echo "1. Flutter Installation:"
flutter --version
echo ""

echo "2. Flutter Doctor (Platform Support):"
flutter doctor
echo ""

echo "3. Available Devices:"
flutter devices
echo ""

echo "4. Project Dependencies:"
flutter pub get
echo ""

echo "5. Code Analysis:"
flutter analyze
echo ""

echo "6. Running Tests:"
flutter test
echo ""

echo "=== Setup Check Complete ==="
echo ""
echo "To run the app, use one of these commands:"
echo "  flutter run -d chrome          # Web (Chrome)"
echo "  flutter run -d linux           # Linux Desktop"
echo "  flutter run -d android         # Android (if device/emulator connected)"
echo "  flutter run -d web-server      # Web Server"
echo ""
echo "To see all available devices: flutter devices" 