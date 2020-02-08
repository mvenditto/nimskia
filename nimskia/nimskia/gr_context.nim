import ../wrapper/gr_context
import ../wrapper/sk_types
import internals/exceptions

type
  GRContext* = ref object
    native*: ptr gr_context_t

  GRGlInterface* = ref object
    native*: ptr gr_glinterface_t

  GRBackendRenderTarget* = ref object
    native*: ptr gr_backendrendertarget_t

  GRGlFramebufferInfo* = ref object
    native*: ptr gr_gl_framebufferinfo_t

  GRBackend* = enum
    Metal = METAL_GR_BACKEND
    OpenGL = OPENGL_GR_BACKEND
    Vulkan = VULKAN_GR_BACKEND

  GRBackendState* {.pure.} = enum
    None = 0.uint32
    All = 0xffffffff

  GRGlBackendState* = enum
    None = 0.uint32
    RenderTarget = 1 shl 0
    TextureBinding = 1 shl 1
    View = 1 shl 2
    Blend = 1 shl 3
    MSAAEnable = 1 shl 4
    Vertex = 1 shl 5
    Stencil = 1 shl 6
    PixelStore = 1 shl 7
    Program = 1 shl 8
    FixedFunction = 1 shl 9
    Misc = 1 shl 10
    PathRendering = 1 shl 11
    All = 0xffff
  
  GRSurfaceOrigin* = enum
    TopLeft = 0.uint32,
    BottomLeft


proc newFrameBufferInfo*(fFBOID: uint32, format: uint32): GRGlFramebufferInfo =
  var info = cast[ptr gr_gl_framebufferinfo_t](alloc(sizeof(gr_gl_framebufferinfo_t)))
  info.fFBOID = fFBOID
  info.fFormat = format
  GRGlFramebufferInfo(native: info)

proc dispose*(this: GRGlFramebufferInfo) = dealloc(this.native)

proc flush*(this: GRContext) =
  gr_context_flush(this.native)

proc createGL*(iface: GRGlInterface): GRContext =
  var ctx = gr_context_make_gl(
    if isNil(iface): cast[ptr gr_glinterface_t](0) else: iface.native
  )
  GRContext(native: ctx)

proc createGL*(): GRContext =
  createGL(nil)

proc abandonContext*(this: GRContext, releaseResources: bool) =
  if releaseResources:
    gr_context_release_resources_and_abandon_context(this.native)
  else:
    gr_context_abandon_context(this.native)

proc createGRContext*(backend: GRBackend): GRContext =
  case backend:
    of Metal:
      notSupported("Metal backend")
    of OpenGL:
      result = createGL()
    of Vulkan:
      notSupported("Vulkan backend")

proc resetContext*(this: GRContext, state: GRGlBackendState) =
  gr_context_reset_context(this.native, state.uint32)

proc resetContext*(this: GRContext, state: GRBackendState) =
  gr_context_reset_context(this.native, state.uint32)

template samples*(this: GRBackendRenderTarget): int =
  gr_backendrendertarget_get_samples(this.native).int

template stencils*(this: GRBackendRenderTarget): int =
  gr_backendrendertarget_get_stencils(this.native).int

proc createBackendRenderTarget*(
  width: int32, height: int32, sampleCount: int32, stencilBits: int32, glInfo: GRGlFramebufferInfo): GRBackendRenderTarget =
  var handle = gr_backendrendertarget_new_gl(width, height, sampleCount, stencilBits, glInfo.native)
  assert(cast[uint](handle) != 0, "Unable to create a new GRBackendRenderTarget instance.")
  GRBackendRenderTarget(native: handle)

proc dispose*(this: GRBackendRenderTarget) =
  gr_backendrendertarget_delete(this.native)

proc createNativeGlInterface*(): GRGlInterface =
  new(result)
  result.native = gr_glinterface_create_native_interface()

proc validate*(this: GRGlInterface): bool =
  gr_glinterface_validate(this.native)