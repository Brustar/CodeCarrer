#!/bin/sh

xcodebuild -sdk iphonesimulator9.2
xcodebuild -sdk iphoneos9.2
if [ -a build/Release-iphoneos/libvproc.a ];
then
    echo "start create..."
    lipo -create build/Release-iphoneos/libvproc.a build/Release-iphonesimulator/libvproc.a -output ../VProcTest/VProcTest/libvproc_fat.a
    echo "create fat success."
fi
