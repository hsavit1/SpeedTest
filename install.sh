#!/bin/bash
set -e

echo "Installing Speed Test..."

WORKDIR=$(mktemp -d)
ZIPURL="https://github.com/hsavit1/SpeedTest/releases/latest/download/SpeedTest-v1.0.0.zip"

curl -sL "$ZIPURL" -o "$WORKDIR/SpeedTest.zip"
ditto -xk "$WORKDIR/SpeedTest.zip" "$WORKDIR"
killall SpeedTest 2>/dev/null || true
rm -rf "/Applications/Speed Test.app"
ditto "$WORKDIR/Speed Test.app" "/Applications/Speed Test.app"
xattr -cr "/Applications/Speed Test.app"
rm -rf "$WORKDIR"

echo "Speed Test installed to /Applications."
echo "Opening..."
open "/Applications/Speed Test.app"
