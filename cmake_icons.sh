#!/bin/bash

OUTPUT=icons
if [ ! -z "${1}" ]; then
  OUTPUT=$1
fi

echo "The output directory for cmake_icons.sh is ${OUTPUT}"

sh GenerateIcons/generateSystemImages.sh `pwd`/project.in/platform/  ${OUTPUT}

mkdir -p build
mkdir -p build/icons
mkdir -p build/icons/emscripten
mkdir -p build/icons/ios/Assets.xcassets
mkdir -p build/icons/appletv/Assets.xcassets
mkdir -p build/icons/macOS/Assets.xcassets
mkdir -p build/icons/watchOS/Assets.xcassets
mkdir -p build/icons/android

cp ${OUTPUT}/emscripten/* build/icons/emscripten/

rm -rf build/icons/ios/Assets.xcassets/
cp -r ${OUTPUT}/ios/* build/icons/ios/

rm -rf build/icons/appletv/Assets.xcassets/
cp -r ${OUTPUT}/tvOS/* build/icons/appletv/

rm -rf build/icons/macOS/Assets.xcassets/
cp -r ${OUTPUT}/macOS/* build/icons/macOS/

rm -rf build/icons/watchOS/Assets.xcassets/
cp -r ${OUTPUT}/watchkit/* build/icons/watchOS/

rm -rf build/icons/android/icons/*
cp -r ${OUTPUT}/android/* build/icons/android/icons/

