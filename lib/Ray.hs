module Ray where

import Vec3 (Vec3 (Vec3, y), scale, unit_vector)
import Colour (Colour)

data Ray = Ray {origin :: Vec3, dir :: Vec3} deriving (Eq)

at :: Ray -> Float -> Vec3
at r t = scale ((origin r) + (dir r)) t

rayColour :: Ray -> Colour
rayColour r = scale (Vec3 1 1 1) (1.0-a) + scale (Vec3 0.5 0.7 1.0) a where
  a = 0.5 * (1 + (y $ unit_vector $ dir r))
