#!/bin/bash
LD_LIBRARY_PATH=../../skia/out/Shared/:../libs/ nim c -o:"bin/$1" -r "$1" 
