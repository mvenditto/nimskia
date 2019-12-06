import ../wrapper/sk_types
import ../wrapper/sk_patheffect

import sk_enums
import sk_path

import internals/native

type
  SKPathEffect* = ref object of SKObject[sk_path_effect_t]

proc dispose*(this: SKPathEffect) =
  sk_patheffect_unref(this.native)

proc newDash*(intervals: openArray[float], count: int, phase: float): SKPathEffect = 
  SKPathEffect(
    native: sk_patheffect_create_dash(
      cast[ptr cfloat](intervals[0].unsafeAddr), 
      count.cint, 
      phase.cfloat
    ) 
  )

proc newDash*(intervals: openArray[float], phase: float): SKPathEffect = 
  SKPathEffect(
    native: sk_patheffect_create_dash(
      cast[ptr cfloat](intervals[0].unsafeAddr), 
      len(intervals).cint, 
      phase.cfloat
    ) 
  )

proc newDescretePathEffect*(segmentLen: float, deviation: float, seed: uint): SKPathEffect =
  SKPathEffect(
    native: sk_path_effect_create_discrete(
      segmentLen.cfloat, 
      deviation.cfloat, 
      seed.uint32
    )
  )

proc new1DPathEffect*(
  path: SKPath, 
  advance: float, phase: 
  float, style: 
  SKPathEffect1DStyle): SKPathEffect = 
  SKPathEffect(
    native: sk_path_effect_create_1d_path(
      path.native,
      advance.cfloat,
      phase.cfloat,
      style.sk_path_effect_1d_style_t
    )
  )

proc sum*(first: SKPathEffect, second: SKPathEffect): SKPathEffect =
  SKPathEffect(native: sk_path_effect_create_sum(first.native, second.native))

proc `+`* (first: SKPathEffect, second: SKPathEffect): SKPathEffect = sum(first, second)
  