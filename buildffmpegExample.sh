#!/bin/bash

set -e

if [ $# != 1 ] ; then
    echo "please input a C file."
    exit 1
fi

BINARY_NAME=$(basename $1 .c)

gcc -Wall -ggdb $1 -I/usr/local/include/ -c -o "$BINARY_NAME.o"
echo "$BINARY_NAME.o builded."

gcc -Wall -ggdb "$BINARY_NAME.o" -L/usr/local/lib -lavdevice -lavfilter -lavformat -lavcodec -lswresample -lswscale -lavutil -framework QTKit -framework Foundation -framework QuartzCore -framework CoreVideo -framework Foundation -framework AVFoundation -framework CoreMedia -framework CoreFoundation -framework VideoDecodeAcceleration -framework QuartzCore -liconv -L/usr/lib -Wl,-framework,Cocoa -lm -lbz2 -lz -o "$BINARY_NAME"
echo "Binary $BINARY_NAME build success,Please execute './$BINARY_NAME example.mp4.' "
