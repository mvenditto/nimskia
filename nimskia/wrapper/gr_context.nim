when defined(Linux):
  const dynlibgr_context = "libskia.so"
when defined(Windows):
  const dynlibgr_context = "libskia.dll"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc gr_context_make_gl*(glInterface: ptr gr_glinterface_t): ptr gr_context_t {.cdecl,
    importc: "gr_context_make_gl", dynlib: dynlibgr_context.}
proc gr_context_unref*(context: ptr gr_context_t) {.cdecl,
    importc: "gr_context_unref", dynlib: dynlibgr_context.}
proc gr_context_abandon_context*(context: ptr gr_context_t) {.cdecl,
    importc: "gr_context_abandon_context", dynlib: dynlibgr_context.}
proc gr_context_release_resources_and_abandon_context*(context: ptr gr_context_t) {.
    cdecl, importc: "gr_context_release_resources_and_abandon_context",
    dynlib: dynlibgr_context.}
proc gr_context_get_resource_cache_limits*(context: ptr gr_context_t;
    maxResources: ptr cint; maxResourceBytes: ptr csize) {.cdecl,
    importc: "gr_context_get_resource_cache_limits", dynlib: dynlibgr_context.}
proc gr_context_set_resource_cache_limits*(context: ptr gr_context_t;
    maxResources: cint; maxResourceBytes: csize) {.cdecl,
    importc: "gr_context_set_resource_cache_limits", dynlib: dynlibgr_context.}
proc gr_context_get_resource_cache_usage*(context: ptr gr_context_t;
    maxResources: ptr cint; maxResourceBytes: ptr csize) {.cdecl,
    importc: "gr_context_get_resource_cache_usage", dynlib: dynlibgr_context.}
proc gr_context_get_max_surface_sample_count_for_color_type*(
    context: ptr gr_context_t; colorType: sk_colortype_t): cint {.cdecl,
    importc: "gr_context_get_max_surface_sample_count_for_color_type",
    dynlib: dynlibgr_context.}
proc gr_context_flush*(context: ptr gr_context_t) {.cdecl,
    importc: "gr_context_flush", dynlib: dynlibgr_context.}
proc gr_context_reset_context*(context: ptr gr_context_t; state: uint32) {.cdecl,
    importc: "gr_context_reset_context", dynlib: dynlibgr_context.}
proc gr_context_get_backend*(context: ptr gr_context_t): gr_backend_t {.cdecl,
    importc: "gr_context_get_backend", dynlib: dynlibgr_context.}
proc gr_glinterface_create_native_interface*(): ptr gr_glinterface_t {.cdecl,
    importc: "gr_glinterface_create_native_interface", dynlib: dynlibgr_context.}
proc gr_glinterface_assemble_interface*(ctx: pointer; get: gr_gl_get_proc): ptr gr_glinterface_t {.
    cdecl, importc: "gr_glinterface_assemble_interface", dynlib: dynlibgr_context.}
proc gr_glinterface_assemble_gl_interface*(ctx: pointer; get: gr_gl_get_proc): ptr gr_glinterface_t {.
    cdecl, importc: "gr_glinterface_assemble_gl_interface",
    dynlib: dynlibgr_context.}
proc gr_glinterface_assemble_gles_interface*(ctx: pointer; get: gr_gl_get_proc): ptr gr_glinterface_t {.
    cdecl, importc: "gr_glinterface_assemble_gles_interface",
    dynlib: dynlibgr_context.}
proc gr_glinterface_unref*(glInterface: ptr gr_glinterface_t) {.cdecl,
    importc: "gr_glinterface_unref", dynlib: dynlibgr_context.}
proc gr_glinterface_validate*(glInterface: ptr gr_glinterface_t): bool {.cdecl,
    importc: "gr_glinterface_validate", dynlib: dynlibgr_context.}
proc gr_glinterface_has_extension*(glInterface: ptr gr_glinterface_t;
                                  extension: cstring): bool {.cdecl,
    importc: "gr_glinterface_has_extension", dynlib: dynlibgr_context.}
proc gr_backendtexture_new_gl*(width: cint; height: cint; mipmapped: bool;
                              glInfo: ptr gr_gl_textureinfo_t): ptr gr_backendtexture_t {.
    cdecl, importc: "gr_backendtexture_new_gl", dynlib: dynlibgr_context.}
proc gr_backendtexture_delete*(texture: ptr gr_backendtexture_t) {.cdecl,
    importc: "gr_backendtexture_delete", dynlib: dynlibgr_context.}
proc gr_backendtexture_is_valid*(texture: ptr gr_backendtexture_t): bool {.cdecl,
    importc: "gr_backendtexture_is_valid", dynlib: dynlibgr_context.}
proc gr_backendtexture_get_width*(texture: ptr gr_backendtexture_t): cint {.cdecl,
    importc: "gr_backendtexture_get_width", dynlib: dynlibgr_context.}
proc gr_backendtexture_get_height*(texture: ptr gr_backendtexture_t): cint {.cdecl,
    importc: "gr_backendtexture_get_height", dynlib: dynlibgr_context.}
proc gr_backendtexture_has_mipmaps*(texture: ptr gr_backendtexture_t): bool {.cdecl,
    importc: "gr_backendtexture_has_mipmaps", dynlib: dynlibgr_context.}
proc gr_backendtexture_get_backend*(texture: ptr gr_backendtexture_t): gr_backend_t {.
    cdecl, importc: "gr_backendtexture_get_backend", dynlib: dynlibgr_context.}
proc gr_backendtexture_get_gl_textureinfo*(texture: ptr gr_backendtexture_t;
    glInfo: ptr gr_gl_textureinfo_t): bool {.cdecl,
    importc: "gr_backendtexture_get_gl_textureinfo", dynlib: dynlibgr_context.}
proc gr_backendrendertarget_new_gl*(width: cint; height: cint; samples: cint;
                                   stencils: cint;
                                   glInfo: ptr gr_gl_framebufferinfo_t): ptr gr_backendrendertarget_t {.
    cdecl, importc: "gr_backendrendertarget_new_gl", dynlib: dynlibgr_context.}
proc gr_backendrendertarget_delete*(rendertarget: ptr gr_backendrendertarget_t) {.
    cdecl, importc: "gr_backendrendertarget_delete", dynlib: dynlibgr_context.}
proc gr_backendrendertarget_is_valid*(rendertarget: ptr gr_backendrendertarget_t): bool {.
    cdecl, importc: "gr_backendrendertarget_is_valid", dynlib: dynlibgr_context.}
proc gr_backendrendertarget_get_width*(rendertarget: ptr gr_backendrendertarget_t): cint {.
    cdecl, importc: "gr_backendrendertarget_get_width", dynlib: dynlibgr_context.}
proc gr_backendrendertarget_get_height*(rendertarget: ptr gr_backendrendertarget_t): cint {.
    cdecl, importc: "gr_backendrendertarget_get_height", dynlib: dynlibgr_context.}
proc gr_backendrendertarget_get_samples*(rendertarget: ptr gr_backendrendertarget_t): cint {.
    cdecl, importc: "gr_backendrendertarget_get_samples", dynlib: dynlibgr_context.}
proc gr_backendrendertarget_get_stencils*(
    rendertarget: ptr gr_backendrendertarget_t): cint {.cdecl,
    importc: "gr_backendrendertarget_get_stencils", dynlib: dynlibgr_context.}
proc gr_backendrendertarget_get_backend*(rendertarget: ptr gr_backendrendertarget_t): gr_backend_t {.
    cdecl, importc: "gr_backendrendertarget_get_backend", dynlib: dynlibgr_context.}
proc gr_backendrendertarget_get_gl_framebufferinfo*(
    rendertarget: ptr gr_backendrendertarget_t; glInfo: ptr gr_gl_framebufferinfo_t): bool {.
    cdecl, importc: "gr_backendrendertarget_get_gl_framebufferinfo",
    dynlib: dynlibgr_context.}