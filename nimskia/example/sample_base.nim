import nimgl/[glfw, opengl]

import ../nimskia/[
  sk_canvas, 
  gr_context,
  sk_surface,
  sk_enums,
  sk_matrix
]

import common_api

type Sample* = ref object
  title*: string
  w*, h*: int32
  update*: proc(canvas: SKCanvas, dt: float)
  surface*: SKSurface

var
  surface: SKSurface = nil
  customKeyProc*: proc(key: int32, scancode: int32, action: int32, mods: int32)

proc keyProc(window: GLFWWindow, key: int32, scancode: int32,
             action: int32, mods: int32): void {.cdecl.} =
  if key == GLFWKey.ESCAPE and action == GLFWPress:
    window.setWindowShouldClose(true)
  if key == GLFWKey.S and action == GLFWPress:
    emitPng("snapshot.png", surface)
  if customKeyProc != nil:
    customKeyProc(key, scancode, action, mods)

proc start*(this: Sample) =
  assert glfwInit()
  glfwWindowHint(GLFWContextVersionMajor, 3)
  glfwWindowHint(GLFWContextVersionMinor, 3)
  glfwWindowHint(GLFWOpenglForwardCompat, GLFW_TRUE) 
  glfwWindowHint(GLFWOpenglProfile, GLFW_OPENGL_CORE_PROFILE)
  glfwWindowHint(GLFWResizable, GLFW_FALSE)

  let w = glfwCreateWindow(this.w, this.h, this.title)
  assert(not isNil w, "Cannot create a new GLFW window.")

  discard w.setKeyCallback(keyProc)
  w.makeContextCurrent()
  assert glInit()

  var grContext = createGL()
  assert not isNil grContext

  var info = newFrameBufferInfo(0, GL_RGBA8.uint32)
  assert not isNil info

  var target = createBackendRenderTarget(this.w, this.h, 0, 0, info)
  assert not isNil target

  surface = newSurface(
      grContext,
      target,
      BottomLeft,
      Rgba8888,
      nil,
      nil
  )
  assert not isNil surface
  this.surface = surface

  discard """
  var flipMatrix: SKMatrix = (
   -1.0, 0.0, 0.0, 
    0.0,-1.0, 0.0, 
    0.0, 0.0, 1.0
  )
  """

  var latest = glfwGetTime()
  while not w.windowShouldClose:
    glfwPollEvents()
    let now = glfwGetTime()
    let dt = now - latest
    latest = now
    this.update(surface.canvas, dt)
    grContext.flush()
    w.swapBuffers()

  w.destroyWindow()
  glfwTerminate()
  grContext.abandonContext(true)
  surface.dispose()
  info.dispose()


