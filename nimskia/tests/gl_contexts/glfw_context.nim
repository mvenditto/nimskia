import nimgl/[glfw, opengl]

import gl_context

type
  GlfwContext* = ref GlfwContextObj
  GlfwContextObj* = object of GlContextObj
    window: GLFWWindow

proc glfwMakeCurrent(ctx: GlContext) =
  var ctx = GlfwContext(ctx)
  ctx.window.makeContextCurrent()
  assert glInit()
  glEnable(GL_MULTISAMPLE)

proc glfwDestroy(ctx: GlContext) = 
  var ctx = GlfwContext(ctx)
  ctx.window.destroyWindow()

proc glfwSwapBuffers(ctx: GlContext) =
  var ctx = GlfwContext(ctx)
  ctx.window.swapBuffers()

proc newGlfwContext*(): GlfwContext =
  new(result)
  
  assert glfwInit()
  
  glfwWindowHint(GLFWContextVersionMajor, 3)
  glfwWindowHint(GLFWContextVersionMinor, 0)
  glfwWindowHint(GLFWOpenglForwardCompat, GLFW_TRUE) 
  glfwWindowHint(GLFWOpenglProfile, GLFWOpenglAnyProfile)
  glfwWindowHint(GLFWResizable, GLFW_FALSE)
  glfwWindowHint(GLFWDoublebuffer, GLFW_TRUE)
  glfwWindowHint(GLFWStencilBits, 8)
  glfwWindowHint(GLFWSamples, 4)
  glfwWindowHint(GLFWSrgbCapable, GLFW_TRUE)
  glfwWindowHint(GLFW_VISIBLE, GLFW_FALSE);

  result.window = glfwCreateWindow(640, 480, "", nil)
  assert(not isNil result.window, "Cannot create a new GLFW window.")

  result.swapBuffersImpl = glfwSwapBuffers
  result.destroyImpl = glfwDestroy
  result.makeCurrentImpl = glfwMakeCurrent
  

  


