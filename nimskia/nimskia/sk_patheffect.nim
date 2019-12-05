import ../wrapper/sk_types
import ../wrapper/sk_patheffect

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
