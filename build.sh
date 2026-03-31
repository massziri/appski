#!/bin/bash
set -e

# Download and setup Flutter SDK
echo ">>> Installing Flutter SDK..."
git clone https://github.com/flutter/flutter.git -b stable --depth 1 /tmp/flutter-sdk
export PATH="/tmp/flutter-sdk/bin:$PATH"

echo ">>> Flutter version:"
flutter --version

echo ">>> Getting dependencies..."
flutter pub get

echo ">>> Building web..."
flutter build web --release --web-renderer html

echo ">>> Build complete!"
