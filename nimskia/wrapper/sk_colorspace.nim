when defined(Linux):
  const dynlibsk_colorspace = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
proc sk_colorspace_unref*(cColorSpace: ptr sk_colorspace_t) {.cdecl,
    importc: "sk_colorspace_unref", dynlib: dynlibsk_colorspace.}
proc sk_colorspace_new_srgb*(): ptr sk_colorspace_t {.cdecl,
    importc: "sk_colorspace_new_srgb", dynlib: dynlibsk_colorspace.}
proc sk_colorspace_new_srgb_linear*(): ptr sk_colorspace_t {.cdecl,
    importc: "sk_colorspace_new_srgb_linear", dynlib: dynlibsk_colorspace.}
proc sk_colorspace_new_icc*(input: pointer; len: csize): ptr sk_colorspace_t {.cdecl,
    importc: "sk_colorspace_new_icc", dynlib: dynlibsk_colorspace.}
proc sk_colorspace_new_rgb_with_gamma*(gamma: sk_colorspace_render_target_gamma_t;
                                      toXYZD50: ptr sk_matrix44_t): ptr sk_colorspace_t {.
    cdecl, importc: "sk_colorspace_new_rgb_with_gamma", dynlib: dynlibsk_colorspace.}
proc sk_colorspace_new_rgb_with_gamma_and_gamut*(
    gamma: sk_colorspace_render_target_gamma_t; gamut: sk_colorspace_gamut_t): ptr sk_colorspace_t {.
    cdecl, importc: "sk_colorspace_new_rgb_with_gamma_and_gamut",
    dynlib: dynlibsk_colorspace.}
proc sk_colorspace_new_rgb_with_coeffs*(coeffs: ptr sk_colorspace_transfer_fn_t;
                                       toXYZD50: ptr sk_matrix44_t): ptr sk_colorspace_t {.
    cdecl, importc: "sk_colorspace_new_rgb_with_coeffs",
    dynlib: dynlibsk_colorspace.}
proc sk_colorspace_new_rgb_with_coeffs_and_gamut*(
    coeffs: ptr sk_colorspace_transfer_fn_t; gamut: sk_colorspace_gamut_t): ptr sk_colorspace_t {.
    cdecl, importc: "sk_colorspace_new_rgb_with_coeffs_and_gamut",
    dynlib: dynlibsk_colorspace.}
proc sk_colorspace_new_rgb_with_gamma_named*(gamma: sk_gamma_named_t;
    toXYZD50: ptr sk_matrix44_t): ptr sk_colorspace_t {.cdecl,
    importc: "sk_colorspace_new_rgb_with_gamma_named", dynlib: dynlibsk_colorspace.}
proc sk_colorspace_new_rgb_with_gamma_named_and_gamut*(gamma: sk_gamma_named_t;
    gamut: sk_colorspace_gamut_t): ptr sk_colorspace_t {.cdecl,
    importc: "sk_colorspace_new_rgb_with_gamma_named_and_gamut",
    dynlib: dynlibsk_colorspace.}
proc sk_colorspace_gamma_get_type*(cColorSpace: ptr sk_colorspace_t): sk_colorspace_type_t {.
    cdecl, importc: "sk_colorspace_gamma_get_type", dynlib: dynlibsk_colorspace.}
proc sk_colorspace_gamma_get_gamma_named*(cColorSpace: ptr sk_colorspace_t): sk_gamma_named_t {.
    cdecl, importc: "sk_colorspace_gamma_get_gamma_named",
    dynlib: dynlibsk_colorspace.}
proc sk_colorspace_gamma_close_to_srgb*(cColorSpace: ptr sk_colorspace_t): bool {.
    cdecl, importc: "sk_colorspace_gamma_close_to_srgb",
    dynlib: dynlibsk_colorspace.}
proc sk_colorspace_gamma_is_linear*(cColorSpace: ptr sk_colorspace_t): bool {.cdecl,
    importc: "sk_colorspace_gamma_is_linear", dynlib: dynlibsk_colorspace.}
proc sk_colorspace_is_srgb*(cColorSpace: ptr sk_colorspace_t): bool {.cdecl,
    importc: "sk_colorspace_is_srgb", dynlib: dynlibsk_colorspace.}
proc sk_colorspace_equals*(src: ptr sk_colorspace_t; dst: ptr sk_colorspace_t): bool {.
    cdecl, importc: "sk_colorspace_equals", dynlib: dynlibsk_colorspace.}
proc sk_colorspace_to_xyzd50*(cColorSpace: ptr sk_colorspace_t;
                             toXYZD50: ptr sk_matrix44_t): bool {.cdecl,
    importc: "sk_colorspace_to_xyzd50", dynlib: dynlibsk_colorspace.}
proc sk_colorspace_as_to_xyzd50*(cColorSpace: ptr sk_colorspace_t): ptr sk_matrix44_t {.
    cdecl, importc: "sk_colorspace_as_to_xyzd50", dynlib: dynlibsk_colorspace.}
proc sk_colorspace_as_from_xyzd50*(cColorSpace: ptr sk_colorspace_t): ptr sk_matrix44_t {.
    cdecl, importc: "sk_colorspace_as_from_xyzd50", dynlib: dynlibsk_colorspace.}
proc sk_colorspace_is_numerical_transfer_fn*(cColorSpace: ptr sk_colorspace_t;
    fn: ptr sk_colorspace_transfer_fn_t): bool {.cdecl,
    importc: "sk_colorspace_is_numerical_transfer_fn", dynlib: dynlibsk_colorspace.}
proc sk_colorspaceprimaries_to_xyzd50*(primaries: ptr sk_colorspaceprimaries_t;
                                      toXYZD50: ptr sk_matrix44_t): bool {.cdecl,
    importc: "sk_colorspaceprimaries_to_xyzd50", dynlib: dynlibsk_colorspace.}
proc sk_colorspace_transfer_fn_invert*(transfer: ptr sk_colorspace_transfer_fn_t;
                                      inverted: ptr sk_colorspace_transfer_fn_t) {.
    cdecl, importc: "sk_colorspace_transfer_fn_invert", dynlib: dynlibsk_colorspace.}
proc sk_colorspace_transfer_fn_transform*(
    transfer: ptr sk_colorspace_transfer_fn_t; x: cfloat): cfloat {.cdecl,
    importc: "sk_colorspace_transfer_fn_transform", dynlib: dynlibsk_colorspace.}