when defined(Linux):
  const dynlibsk_vertices = "libskia.so"
when defined(Windows):
  const dynlibsk_vertices = "libskia.dll"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_vertices_unref*(cvertices: ptr sk_vertices_t) {.cdecl,
    importc: "sk_vertices_unref", dynlib: dynlibsk_vertices.}
proc sk_vertices_ref*(cvertices: ptr sk_vertices_t) {.cdecl,
    importc: "sk_vertices_ref", dynlib: dynlibsk_vertices.}
proc sk_vertices_make_copy*(vmode: sk_vertices_vertex_mode_t; vertexCount: cint;
                           positions: ptr sk_point_t; texs: ptr sk_point_t;
                           colors: ptr sk_color_t; indexCount: cint;
                           indices: ptr uint16): ptr sk_vertices_t {.cdecl,
    importc: "sk_vertices_make_copy", dynlib: dynlibsk_vertices.}