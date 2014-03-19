#!/bin/sh
xcodebuild -project ../src/Select\ Random\ Items.xcodeproj
cp -R ../src/build/Release/Select\ Random\ Items.action ../Sample/
