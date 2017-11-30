#!/bin/bash

OUTPUT=icons
if [ ! -z "${1}" ]; then
  OUTPUT=$1
fi

echo "The output directory for cmake_icons.sh is ${OUTPUT}"

sh GenerateIcons/generateSystemImages.sh `pwd`/project.in/platform/  ${OUTPUT}

mkdir -p projects
mkdir -p projects/icons
mkdir -p projects/icons/emscripten
mkdir -p projects/icons/ios/Assets.xcassets
mkdir -p projects/icons/appletv/Assets.xcassets
mkdir -p projects/icons/macOS/Assets.xcassets
mkdir -p projects/icons/watchOS/Assets.xcassets
mkdir -p projects/icons/android

cp ${OUTPUT}/emscripten/* projects/icons/emscripten/

rm -rf projects/icons/ios/Assets.xcassets/
cp -r ${OUTPUT}/ios/* projects/icons/ios/

rm -rf projects/icons/appletv/Assets.xcassets/
cp -r ${OUTPUT}/tvOS/* projects/icons/appletv/

rm -rf projects/icons/macOS/Assets.xcassets/
cp -r ${OUTPUT}/macOS/* projects/icons/macOS/

rm -rf projects/icons/watchOS/Assets.xcassets/
cp -r ${OUTPUT}/watchkit/* projects/icons/watchOS/

rm -rf projects/icons/android/icons/*
cp -r ${OUTPUT}/android/* projects/icons/android/icons/

