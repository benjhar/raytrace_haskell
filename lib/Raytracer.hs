module Raytracer (pixelColour, CamInfo (CamInfo)) where
import Vec3 (Vec3(Vec3), scale)
import Colour (Colour)
import Ray (rayColour, Ray (Ray))
import GHC.Float (int2Float)

data CamInfo = CamInfo { centre :: Vec3,
  pixel00 :: Vec3,
  pixel_delta_u :: Vec3,
  pixel_delta_v :: Vec3}

pixelToRay :: CamInfo -> Int -> Int -> Ray
pixelToRay (CamInfo cam_ctr zero pdu pdv) x y = Ray cam_ctr ((zero + scale pdu (int2Float x) + scale pdv (int2Float y)) - cam_ctr)

pixelColour :: CamInfo -> Int -> Int -> Colour
pixelColour ci x y = rayColour $ pixelToRay ci x y
