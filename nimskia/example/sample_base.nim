import nimgl/[glfw, opengl]

import ../nimskia/[
  sk_canvas, 
  gr_context,
  sk_surface,
  sk_imageinfo,
  sk_enums,
  sk_matrix,
  sk_color
]

import strutils
import os
import common_api

type Sample* = ref object
  title*: string
  w*, h*: int32
  update*: proc(canvas: SKCanvas, dt: float)
  surface*: SKSurface

var
  self: Sample
  scale = (1.float, 1.float)
  surface: SKSurface = nil
  customKeyProc*: proc(key: int32, scancode: int32, action: int32, mods: int32)

const
  numSamples = 4
  numStencilBits = 8
  snapshotsDir = "./snapshots"
  DefaultBg* = newColorARGB(255,247,247,247)

proc keyProc(window: GLFWWindow, key: int32, scancode: int32,
             action: int32, mods: int32): void {.cdecl.} =
  if key == GLFWKey.ESCAPE and action == GLFWPress:
    window.setWindowShouldClose(true)
  if key == GLFWKey.S and action == GLFWPress:

    let file = self.title
      .replace(" ", "_")
      .replace(".", "_")
      .replace(":", "_") & ".png"

    if not dirExists snapshotsDir:
      createDir(snapshotsDir)
    
    emitPng(joinPath(snapshotsDir, file), surface)
    
  if customKeyProc != nil:
    customKeyProc(key, scancode, action, mods)

proc start*(this: Sample) =
  self = this

  assert glfwInit()
  glfwWindowHint(GLFWContextVersionMajor, 3)
  glfwWindowHint(GLFWContextVersionMinor, 3)
  glfwWindowHint(GLFWOpenglForwardCompat, GLFW_TRUE) 
  glfwWindowHint(GLFWOpenglProfile, GLFWOpenglAnyProfile)
  glfwWindowHint(GLFWResizable, GLFW_FALSE)
  glfwWindowHint(GLFWDoublebuffer, GLFW_TRUE)
  glfwWindowHint(GLFWStencilBits, numStencilBits)
  glfwWindowHint(GLFWSamples, numSamples)
  glfwWindowHint(GLFWSrgbCapable, GLFW_TRUE)

  let w = glfwCreateWindow(this.w, this.h, this.title)
  assert(not isNil w, "Cannot create a new GLFW window.")

  discard w.setKeyCallback(keyProc)
  w.makeContextCurrent()
  assert glInit()

  glEnable(GL_MULTISAMPLE)

  var grContext = createGL()
  assert not isNil grContext

  var info = newFrameBufferInfo(0, GL_RGBA8.uint32) #GL_BGRA8
  assert not isNil info


  discard """
  var samples: GLInt 
  var stencil: GLInt
  glGetIntegerv(GL_SAMPLES, samples.addr)
  glGetIntegerv(GL_STENCIL_BITS, stencil.addr)
  echo "samples: " & $samples
  echo "stencilBits: " & $stencil
  """

  var target = createBackendRenderTarget(this.w, this.h, 0, numStencilBits, info)
  assert not isNil target  

  echo "platformColor: " & $platformColorType
  echo "samples: " & $target.samples
  echo "stencilBits: " & $target.stencils

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
  var fbh, fbw: int32
  w.getFramebufferSize(fbw.addr, fbh.addr)
  scale[0] = fbw.float / this.w.float
  scale[1] = fbh.float / this.h.float
  echo $scale

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


