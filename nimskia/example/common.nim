import ../wrapper/sk_types
import ../wrapper/sk_paint
import ../wrapper/sk_canvas
import ../wrapper/sk_path

proc test_draw*(canvas: ptr sk_canvas_t) =
    var fill = sk_paint_new();
    sk_paint_set_color(fill, sk_color_set_argb(0xFF, 0x00, 0x00, 0xFF))
    sk_canvas_draw_paint(canvas, fill)

    sk_paint_set_color(fill, sk_color_set_argb(0xFF, 0x00, 0xFF, 0xFF));
    var rect: sk_rect_t
    rect.left = 100.0f;
    rect.top = 100.0f;
    rect.right = 540.0f;
    rect.bottom = 380.0f;
    sk_canvas_draw_rect(canvas, rect.addr, fill);

    var stroke = sk_paint_new()
    sk_paint_set_color(stroke, sk_color_set_argb(0xFF, 0xFF, 0x00, 0x00))
    sk_paint_set_antialias(stroke, true)
    sk_paint_set_style(stroke, STROKE_SK_PAINT_STYLE)
    sk_paint_set_stroke_width(stroke, 5.0f)
    var path = sk_path_new();

    sk_path_move_to(path, 50.0f, 50.0f)
    sk_path_line_to(path, 590.0f, 50.0f)
    sk_path_cubic_to(path, -490.0f, 50.0f, 1130.0f, 430.0f, 50.0f, 430.0f)
    sk_path_line_to(path, 590.0f, 430.0f)
    sk_canvas_draw_path(canvas, path, stroke)

    sk_paint_set_color(fill, sk_color_set_argb(0x80, 0x00, 0xFF, 0x00));
    var rect2: sk_rect_t;
    rect2.left = 120.0f;
    rect2.top = 120.0f;
    rect2.right = 520.0f;
    rect2.bottom = 360.0f;
    sk_canvas_draw_oval(canvas, rect2.addr, fill);
    
    sk_path_delete(path)
    sk_paint_delete(stroke)
    sk_paint_delete(fill)