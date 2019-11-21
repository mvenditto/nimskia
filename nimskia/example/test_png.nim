import ../wrapper/sk_types
import ../wrapper/sk_imageinfo
import ../wrapper/sk_image
import ../wrapper/sk_data
import ../wrapper/sk_surface

import common

proc make_surface(w: int32; h: int32): ptr sk_surface_t =
    var info = sk_imageinfo_new(w, h, RGBA_8888_SK_COLORTYPE, PREMUL_SK_ALPHATYPE, nil)
    return sk_surface_new_raster(info, nil)

proc emit_png(path: string; surface: ptr sk_surface_t) =
    var image = sk_surface_new_image_snapshot(surface)
    var data = sk_image_encode(image)
    sk_image_unref(image)
    var f = open(path, fmWrite)
    var data_buff = sk_data_get_data(data)
    var data_len = sk_data_get_size(data)
    discard f.writeBuffer(data_buff, data_len)
    close(f)
    sk_data_unref(data)

proc main() =
    var surface = make_surface(640, 480)
    var canvas = sk_surface_get_canvas(surface)
    test_draw(canvas)
    emit_png("skia-c-example.png", surface);
    sk_surface_unref(surface)

main()

