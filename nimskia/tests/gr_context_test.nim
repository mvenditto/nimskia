import unittest

import ../nimskia/[
  gr_context,
  sk_surface,
  sk_imageinfo,
  sk_canvas,
  sk_colors
]
import gl_contexts/gl_context
import test_common

suite "GRContext tests":
  test "create default context is valid":
    let ctx = createGlContext()
    ctx.makeCurrent()
    defer: ctx.dispose()
    let grContext = createGL()
    check(not isNil grContext.native)

  test "create specific context is valid":
    let ctx = createGlContext()
    ctx.makeCurrent()
    defer: ctx.dispose()
    let glInterface = createNativeGlInterface()
    check(glInterface.validate())
    let grContext = createGL(glInterface)
    check(not isNil grContext.native)

  test "GPU surface is created":
    let ctx = createGlContext()
    ctx.makeCurrent()
    defer: ctx.dispose()
    let grContext = createGL()
    let gpuSurface = newSurface(grContext, true, newImageInfo(100,100))
    check(not isNil gpuSurface.native)
    check(not isNil gpuSurface.canvas.native)
    gpuSurface.canvas.clear(Transparent)



