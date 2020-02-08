type
  GlContext* = ref GlContextObj
  GlContextObj* = object of RootObj
    makeCurrentImpl*: proc (s: GlContext) {.nimcall.}
    swapBuffersImpl*: proc (s: GlContext) {.nimcall.}
    destroyImpl*: proc (s: GlContext) {.nimcall.}

proc dispose*(ctx: GlContext) = 
  if not isNil(ctx.destroyImpl): ctx.destroyImpl(ctx)

proc makeCurrent*(ctx: GlContext) = 
  if not isNil(ctx.makeCurrentImpl): ctx.makeCurrentImpl(ctx)

proc swapBuffer*(ctx: GlContext) = 
  if not isNil(ctx.swapBuffersImpl): ctx.swapBuffersImpl(ctx)

