#!/bin/bash
set -e

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
APP_NAME="Redragon Studio"
APP_BUNDLE="${PROJECT_DIR}/${APP_NAME}.app"

echo "==> Building ${APP_NAME} for macOS..."

# Clean old build
rm -rf "${APP_BUNDLE}"

# Create bundle directory structure
mkdir -p "${APP_BUNDLE}/Contents/MacOS"
mkdir -p "${APP_BUNDLE}/Contents/Resources/web"

# Compile executable
echo "==> Compiling Objective-C executable..."
clang -O2 \
  -framework Cocoa \
  -framework WebKit \
  "${PROJECT_DIR}/main.m" \
  -o "${APP_BUNDLE}/Contents/MacOS/${APP_NAME}"

# Copy Info.plist
cp "${PROJECT_DIR}/Info.plist" "${APP_BUNDLE}/Contents/"

# Copy AppIcon.icns
if [ -f "${PROJECT_DIR}/assets/AppIcon.icns" ]; then
  cp "${PROJECT_DIR}/assets/AppIcon.icns" "${APP_BUNDLE}/Contents/Resources/"
fi

# Copy Web Assets
cp -r "${PROJECT_DIR}/web/"* "${APP_BUNDLE}/Contents/Resources/web/"

# Make executable runnable
chmod +x "${APP_BUNDLE}/Contents/MacOS/${APP_NAME}"

echo "==> Successfully built: ${APP_BUNDLE}"
echo "==> You can now launch '${APP_NAME}.app' or copy it to /Applications"

