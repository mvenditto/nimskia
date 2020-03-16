#!/bin/bash

nimskia=(
  "gr_context"
  "sk_bitmap"
  "sk_canvas"
  "sk_codec"
  "sk_color"
  "sk_colors"
  "sk_colorspace"
  "sk_converters"
  "sk_data"
  "sk_document"
  "sk_enums"
  "sk_imageinfo"
  "sk_image"
  "sk_managedstream"
  "sk_matrix"
  "sk_paint"
  "sk_patheffect"
  "sk_path"
  "sk_pixmap"
  "sk_point"
  "sk_rect"
  "sk_shader"
  "sk_size"
  "sk_stream"
  "sk_string"
  "sk_surface"
  "sk_vertices"
  "sk_shaper"
  "sk_canvas_ext"
)

for src in "${nimskia[@]}"; do
  nim doc2 --out:./docs/"$src.html" --index:on --git.url:https://github.com/mvenditto/nimskia --git.commit:master nimskia/nimskia/"$src.nim"
done

nim buildIndex -o:docs/index.html docs
rm docs/*.idx
 
