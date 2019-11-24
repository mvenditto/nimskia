import nimgl/[glfw, opengl]
import ../nimskia/[
  sk_canvas, 
  sk_paint, 
  sk_surface, 
  sk_enums,
  sk_colors,
  gr_context
]
import common_api

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

  var grContext = createGL()
  assert not isNil grContext

  var info = newFrameBufferInfo(0, GL_RGBA8.uint32)
  assert not isNil info

  var target = createBackendRenderTarget(640, 480, 0, 0, info)
  assert not isNil target
 
  var surface = newSurface(
    grContext,
    target,
    TopLeft,
    Rgba8888,
    nil,
    nil
  )
  assert not isNil surface

  var canvas = surface.canvas
  assert not isNil canvas

  var fill = newPaint(BlueViolet)
  assert not isNil fill
  canvas.drawPaint(fill)
 
  while not w.windowShouldClose:
    glfwPollEvents()
    testDraw(canvas)
    grContext.flush()
    w.swapBuffers()

  w.destroyWindow()
  glfwTerminate()

  grContext.abandonContext(true)
  fill.dispose()
  surface.dispose()
  info.dispose()


main()
