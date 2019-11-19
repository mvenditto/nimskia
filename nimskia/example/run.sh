#!/bin/bash
nim c "$1"
bin="$(cut -d'.' -f1 <<< "$1")"
LD_LIBRARY_PATH=../../skia/out/Shared/:../libs/ "./$bin"
