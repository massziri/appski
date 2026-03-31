#!/bin/bash
set -e

echo ">>> Downloading Flutter SDK..."
curl -sL "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.41.6-stable.tar.xz" -o /tmp/flutter.tar.xz

echo ">>> Extracting Flutter SDK..."
cd /tmp && tar xf flutter.tar.xz
export PATH="/tmp/flutter/bin:/tmp/flutter/bin/cache/dart-sdk/bin:$PATH"

echo ">>> Flutter version:"
flutter --version

echo ">>> Configuring Flutter..."
flutter config --no-analytics 2>/dev/null || true

PROJ_DIR="$(pwd)"
# Vercel clones to /vercel/path0
if [ -f "/vercel/path0/pubspec.yaml" ]; then
  PROJ_DIR="/vercel/path0"
fi
cd "$PROJ_DIR"

echo ">>> Working in: $(pwd)"
echo ">>> Getting dependencies..."
flutter pub get

echo ">>> Building web..."
flutter build web --release --web-renderer html

echo ">>> Build complete!"
ls -la build/web/
