import nimgl/[glfw, opengl]
import ../wrapper/sk_gpu
import ../wrapper/sk_surface
import ../wrapper/sk_canvas
import ../wrapper/sk_types
import ../wrapper/sk_paint

import common

proc keyProc(window: GLFWWindow, key: int32, scancode: int32,
             action: int32, mods: int32): void {.cdecl.} =
  if key == GLFWKey.ESCAPE and action == GLFWPress:
    window.setWindowShouldClose(true)

proc main() =
  assert glfwInit()

  glfwWindowHint(GLFWContextVersionMajor, 3)
  glfwWindowHint(GLFWContextVersionMinor, 3)
  glfwWindowHint(GLFWOpenglForwardCompat, GLFW_TRUE) 
  glfwWindowHint(GLFWOpenglProfile, GLFW_OPENGL_CORE_PROFILE)
  glfwWindowHint(GLFWResizable, GLFW_FALSE)

  let w: GLFWWindow = glfwCreateWindow(640, 480, "NimSkia")
  if w == nil:
    quit(-1)

  discard w.setKeyCallback(keyProc)
  w.makeContextCurrent()
  assert glInit()
  
  var surface = sk_surface_new_from_backend_render_target(640, 480)
  assert not isNil surface

  var canvas = sk_surface_get_canvas(surface);
  assert not isNil canvas

  var fill = sk_paint_new()
  sk_paint_set_color(fill, 0xFF0000FF.sk_color_t)
 
  while not w.windowShouldClose:
    glfwPollEvents()
    test_draw(canvas)
    flush_gr_context()
    w.swapBuffers()

  w.destroyWindow()
  glfwTerminate()

main()
