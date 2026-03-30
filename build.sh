#!/bin/bash
set -e

FLUTTER_VERSION="3.27.4"
FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

echo "=== Installing Flutter SDK ==="
if [ ! -d "flutter" ]; then
  curl -sL "$FLUTTER_URL" | tar xJ
fi
export PATH="$(pwd)/flutter/bin:$PATH"
flutter --version

echo "=== Getting dependencies ==="
flutter pub get

echo "=== Building for web ==="
flutter build web --release

echo "=== Build complete ==="
ls -la build/web/
