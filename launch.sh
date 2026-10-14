#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
APP="${DIR}/Redragon Studio.app"

echo "Launching Redragon Studio..."
open "${APP}" || "${APP}/Contents/MacOS/Redragon Studio" &

