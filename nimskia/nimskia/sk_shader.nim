import internals/native

import ../wrapper/sk_shader
import ../wrapper/sk_types

import sk_point
import sk_enums
import sk_color

type
  SKShader* = ref object of SKObject[sk_shader_t]

proc dispose*(s: SKShader) =
  sk_shader_unref(s.native)

proc newLinearGradient*(
  startp, endp: SKPoint, 
  colors: openArray[SKColor],
  colorPos: openArray[float],
  tileMode: SKShaderTileMode
): SKShader =

  var points: array[0..1, sk_point_t]
  points[0] = startp[]
  points[1] = endp[]

  SKShader(native: sk_shader_new_linear_gradient(
      points,
      cast[ptr sk_color_t](colors[0].unsafeAddr),
      cast[ptr cfloat](colorPos[0].unsafeAddr),
      len(colors).cint,
      tileMode.sk_shader_tilemode_t,
      nil
    )
  )

proc newLinearGradient*(
  startp, endp: SKPoint, 
  colors: openArray[SKColor],
  tileMode: SKShaderTileMode
): SKShader =

  var points: array[0..1, sk_point_t]
  points[0] = startp[]
  points[1] = endp[]

  SKShader(native: sk_shader_new_linear_gradient(
      points,
      cast[ptr sk_color_t](colors[0].unsafeAddr),
      nil,
      len(colors).cint,
      tileMode.sk_shader_tilemode_t,
      nil
    )
  )

proc newRadialGradient*(
  center: SKPoint, 
  radius: float,
  colors: openArray[SKColor],
  colorPos: openArray[float],
  tileMode: SKShaderTileMode
): SKShader =
  SKShader(native: sk_shader_new_radial_gradient(
      center[].addr,
      radius.cfloat,
      cast[ptr sk_color_t](colors[0].unsafeAddr),
      cast[ptr cfloat](colorPos[0].unsafeAddr),
      len(colors).cint,
      tileMode.sk_shader_tilemode_t,
      nil
    )
  )

proc newSweepGradient*(
  center: SKPoint, 
  radius: float,
  colors: openArray[SKColor],
  colorPos: openArray[float],
  tileMode: SKShaderTileMode,
  startAngle, endAngle: float
): SKShader =
  SKShader(native: sk_shader_new_sweep_gradient(
      center[].addr,
      cast[ptr sk_color_t](colors[0].unsafeAddr),
      cast[ptr cfloat](colorPos[0].unsafeAddr),
      len(colors).cint,
      tileMode.sk_shader_tilemode_t,
      startAngle, endAngle,
      nil
    )
  )

proc newSweepGradient*(
  center: SKPoint, 
  radius: float,
  colors: openArray[SKColor],
  tileMode: SKShaderTileMode,
  startAngle, endAngle: float
): SKShader =
  SKShader(native: sk_shader_new_sweep_gradient(
      center[].addr,
      cast[ptr sk_color_t](colors[0].unsafeAddr),
      nil,
      len(colors).cint,
      tileMode.sk_shader_tilemode_t,
      startAngle, endAngle,
      nil
    )
  )

proc newTwoPointConicalGradient*(
  start: SKPoint, startRadius: float,
  `end`: SKPoint, endRadius: float,
  colors: openArray[SKColor],
  colorPos: openArray[float],
  tileMode: SKShaderTileMode
): SKShader =
  SKShader(native: sk_shader_new_two_point_conical_gradient(
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

proc newPerlinNoiseFractal*(
  baseFrequencyX, baseFrequencyY: float,
  numOctaves: int, 
  seed: float,
  tileSize: SKPointI
): SKShader =
  SKShader(native: sk_shader_new_perlin_noise_fractal_noise(
      baseFrequencyX, baseFrequencyY,
      numOctaves.cint,
      seed.cfloat,
      cast[ptr sk_isize_t](tileSize.unsafeAddr)
    )
  )

proc newPerlinNoiseFractal*(
  baseFrequencyX, baseFrequencyY: float,
  numOctaves: int, 
  seed: float,
): SKShader =
  SKShader(native: sk_shader_new_perlin_noise_fractal_noise(
      baseFrequencyX, baseFrequencyY,
      numOctaves.cint,
      seed.cfloat,
      nil
    )
  )

proc newPerlinNoiseTurbolence*(
  baseFrequencyX, baseFrequencyY: float,
  numOctaves: int, 
  seed: float,
  tileSize: SKPointI
): SKShader =
  SKShader(native: sk_shader_new_perlin_noise_turbulence(
      baseFrequencyX, baseFrequencyY,
      numOctaves.cint,
      seed.cfloat,
      cast[ptr sk_isize_t](tileSize.unsafeAddr)
    )
  )

proc newPerlinNoiseTurbolence*(
  baseFrequencyX, baseFrequencyY: float,
  numOctaves: int, 
  seed: float,
): SKShader =
  SKShader(native: sk_shader_new_perlin_noise_turbulence(
      baseFrequencyX, baseFrequencyY,
      numOctaves.cint,
      seed.cfloat,
      nil
    )
  )

proc compose*(a,b: SKShader): SKShader =
  SKShader(native: sk_shader_new_compose(
      a.native, b.native
    )
  )

proc compose*(a,b: SKShader, mode: SKBlendMode): SKShader =
  SKShader(native: sk_shader_new_compose_with_mode(
      a.native, b.native, mode.sk_blendmode_t
    )
  )
