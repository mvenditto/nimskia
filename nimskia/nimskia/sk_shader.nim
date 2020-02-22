import internals/native

import ../wrapper/sk_shader
import ../wrapper/sk_types

import sk_point
import sk_enums
import sk_color
import sk_matrix
import sk_bitmap

type
  SkShader* = ref object of SkObject[sk_shader_t]

proc dispose*(s: SkShader) =
  sk_shader_unref(s.native)

proc newSkLinearGradient*(
  startp, endp: SkPoint, 
  colors: openArray[SkColor],
  colorPos: openArray[float],
  tileMode: SkShaderTileMode
): SkShader =

  var points: array[0..1, sk_point_t]
  points[0] = startp[]
  points[1] = endp[]

  SkShader(native: sk_shader_new_linear_gradient(
      points,
      cast[ptr sk_color_t](colors[0].unsafeAddr),
      cast[ptr cfloat](colorPos[0].unsafeAddr),
      len(colors).cint,
      tileMode.sk_shader_tilemode_t,
      nil
    )
  )

proc newSkLinearGradient*(
  startp, endp: SkPoint, 
  colors: openArray[SkColor],
  tileMode: SkShaderTileMode
): SkShader =

  var points: array[0..1, sk_point_t]
  points[0] = startp[]
  points[1] = endp[]

  SkShader(native: sk_shader_new_linear_gradient(
      points,
      cast[ptr sk_color_t](colors[0].unsafeAddr),
      nil,
      len(colors).cint,
      tileMode.sk_shader_tilemode_t,
      nil
    )
  )

proc newSkRadialGradient*(
  center: SkPoint, 
  radius: float,
  colors: openArray[SkColor],
  colorPos: openArray[float],
  tileMode: SkShaderTileMode
): SkShader =
  SkShader(native: sk_shader_new_radial_gradient(
      center[].addr,
      radius.cfloat,
      cast[ptr sk_color_t](colors[0].unsafeAddr),
      cast[ptr cfloat](colorPos[0].unsafeAddr),
      len(colors).cint,
      tileMode.sk_shader_tilemode_t,
      nil
    )
  )

proc newSkSweepGradient*(
  center: SkPoint, 
  radius: float,
  colors: openArray[SkColor],
  colorPos: openArray[float],
  tileMode: SkShaderTileMode,
  startAngle, endAngle: float
): SkShader =
  SkShader(native: sk_shader_new_sweep_gradient(
      center[].addr,
      cast[ptr sk_color_t](colors[0].unsafeAddr),
      cast[ptr cfloat](colorPos[0].unsafeAddr),
      len(colors).cint,
      tileMode.sk_shader_tilemode_t,
      startAngle, endAngle,
      nil
    )
  )

proc newSkSweepGradient*(
  center: SkPoint, 
  radius: float,
  colors: openArray[SkColor],
  tileMode: SkShaderTileMode,
  startAngle, endAngle: float
): SkShader =
  SkShader(native: sk_shader_new_sweep_gradient(
      center[].addr,
      cast[ptr sk_color_t](colors[0].unsafeAddr),
      nil,
      len(colors).cint,
      tileMode.sk_shader_tilemode_t,
      startAngle, endAngle,
      nil
    )
  )

proc newSkTwoPointConicalGradient*(
  start: SkPoint, startRadius: float,
  `end`: SkPoint, endRadius: float,
  colors: openArray[SkColor],
  colorPos: openArray[float],
  tileMode: SkShaderTileMode
): SkShader =
  SkShader(native: sk_shader_new_two_point_conical_gradient(
      start[].addr,
      startRadius,
      `end`[].addr,
      endRadius,
      cast[ptr sk_color_t](colors[0].unsafeAddr),
      cast[ptr cfloat](colorPos[0].unsafeAddr),
      len(colors).cint,
      tileMode.sk_shader_tilemode_t,
      nil
    )
  )

proc newSkPerlinNoiseFractal*(
  baseFrequencyX, baseFrequencyY: float,
  numOctaves: int, 
  seed: float,
  tileSize: SkPointI
): SkShader =
  SkShader(native: sk_shader_new_perlin_noise_fractal_noise(
      baseFrequencyX, baseFrequencyY,
      numOctaves.cint,
      seed.cfloat,
      cast[ptr sk_isize_t](tileSize.unsafeAddr)
    )
  )

proc newSkPerlinNoiseFractal*(
  baseFrequencyX, baseFrequencyY: float,
  numOctaves: int, 
  seed: float,
): SkShader =
  SkShader(native: sk_shader_new_perlin_noise_fractal_noise(
      baseFrequencyX, baseFrequencyY,
      numOctaves.cint,
      seed.cfloat,
      nil
    )
  )

proc newSkPerlinNoiseTurbolence*(
  baseFrequencyX, baseFrequencyY: float,
  numOctaves: int, 
  seed: float,
  tileSize: SkPointI
): SkShader =
  SkShader(native: sk_shader_new_perlin_noise_turbulence(
      baseFrequencyX, baseFrequencyY,
      numOctaves.cint,
      seed.cfloat,
      cast[ptr sk_isize_t](tileSize.unsafeAddr)
    )
  )

proc newSkPerlinNoiseTurbolence*(
  baseFrequencyX, baseFrequencyY: float,
  numOctaves: int, 
  seed: float,
): SkShader =
  SkShader(native: sk_shader_new_perlin_noise_turbulence(
      baseFrequencyX, baseFrequencyY,
      numOctaves.cint,
      seed.cfloat,
      nil
    )
  )

proc newSkBitmapShader*(
  bitmap: SkBitmap,
  tmx, tmy: SkShaderTileMode,
  localMatrix: SkMatrix
): SkShader = 
  SkShader(native: sk_shader_new_bitmap(
    bitmap.native,
    tmx.sk_shader_tilemode_t,
    tmy.sk_shader_tilemode_t,
    if isNil localMatrix: nil else: localMatrix.native
  ))

template newSkBitmapShader*(
  bitmap: SkBitmap,
  tmx, tmy: SkShaderTileMode
): SkShader = newSkBitmapShader(bitmap, tmx, tmy, nil)

template newSkBitmapShader*(
  bitmap: SkBitmap
): SkShader = newSkBitmapShader(bitmap, Clamp, Clamp, nil)


proc compose*(a,b: SkShader): SkShader =
  SkShader(native: sk_shader_new_compose(
      a.native, b.native
    )
  )

proc compose*(a,b: SkShader, mode: SkBlendMode): SkShader =
  SkShader(native: sk_shader_new_compose_with_mode(
      a.native, b.native, mode.sk_blendmode_t
    )
  )
