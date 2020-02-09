#!/bin/bash
bin="$(cut -d'.' -f1 <<< "$1")"
nim c -o:./bin/"$bin" "$1" && LD_LIBRARY_PATH=../../skia/out/Shared/:../libs/ "./bin/$bin"
