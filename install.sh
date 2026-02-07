#!/bin/bash
set -e

echo "Installing Speed Test..."

TMPDIR=$(mktemp -d)
ZIPURL="https://github.com/hsavit1/SpeedTest/releases/latest/download/SpeedTest-v1.0.0.zip"

curl -sL "$ZIPURL" -o "$TMPDIR/SpeedTest.zip"
ditto -xk "$TMPDIR/SpeedTest.zip" "$TMPDIR"
rm -rf "/Applications/Speed Test.app"
ditto "$TMPDIR/Speed Test.app" "/Applications/Speed Test.app"
xattr -cr "/Applications/Speed Test.app"
rm -rf "$TMPDIR"

echo "Speed Test installed to /Applications."
echo "Opening..."
open "/Applications/Speed Test.app"
