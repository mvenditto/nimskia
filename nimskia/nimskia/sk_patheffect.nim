import ../wrapper/sk_types
import ../wrapper/sk_patheffect

import sk_enums
import sk_path

import internals/native

type
  SkPathEffect* = ref object of SkObject[sk_path_effect_t]

proc dispose*(this: SkPathEffect) =
  sk_patheffect_unref(this.native)

proc newSkDash*(intervals: openArray[float], count: int, phase: float): SkPathEffect = 
  SkPathEffect(
    native: sk_patheffect_create_dash(
      cast[ptr cfloat](intervals[0].unsafeAddr), 
      count.cint, 
      phase.cfloat
    ) 
  )

proc newSkDash*(intervals: openArray[float], phase: float): SkPathEffect = 
  SkPathEffect(
    native: sk_patheffect_create_dash(
      cast[ptr cfloat](intervals[0].unsafeAddr), 
      len(intervals).cint, 
      phase.cfloat
    ) 
  )

proc newSkDescretePathEffect*(segmentLen: float, deviation: float, seed: uint): SkPathEffect =
  SkPathEffect(
    native: sk_path_effect_create_discrete(
      segmentLen.cfloat, 
      deviation.cfloat, 
      seed.uint32
    )
  )

proc newSk1DPathEffect*(
  path: SkPath, 
  advance: float, phase: 
  float, style: 
  SkPathEffect1DStyle): SkPathEffect = 
  SkPathEffect(
    native: sk_path_effect_create_1d_path(
      path.native,
      advance.cfloat,
      phase.cfloat,
      style.sk_path_effect_1d_style_t
    )
  )

proc sum*(first: SkPathEffect, second: SkPathEffect): SkPathEffect =
  SkPathEffect(native: sk_path_effect_create_sum(first.native, second.native))

proc `+`* (first: SkPathEffect, second: SkPathEffect): SkPathEffect = sum(first, second)
  