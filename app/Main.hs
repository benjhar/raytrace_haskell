module Main where

import Raytracer (pixelColour, CamInfo (CamInfo))
import Colour (Colour)
import Vec3 (Vec3(Vec3), scale)
import qualified Vec3 ((/))
import GHC.Float (int2Float, float2Int)
import Ray (Ray (Ray))

pixelArray :: CamInfo -> Int -> Int -> [[Colour]]
pixelArray ci w h = map (\j -> map (\i -> pixelColour ci i j) $ takeWhile (<w) [0..]) $ takeWhile (<h) [0..]

printPixels :: [[Colour]] -> String
printPixels pixels = foldl (++) "" (map printRow pixels)

printRow :: [Colour] -> String
printRow row = foldl (++) "" (map show row)



main :: IO ()
main = do
  let aspect_ratio = 16 / 9
  let image_width = 256
  let image_height = max (round $ int2Float image_width / aspect_ratio) 1

  let focal_length = 1.0
  let viewport_height = 2.0
  let viewport_width = viewport_height * (int2Float image_width / int2Float image_height)
  let camera_center = Vec3 0 0 0

  let viewport_u = Vec3 viewport_width 0 0 
  let viewport_v = Vec3 0 (-viewport_height) 0

  let pixel_delta_u = viewport_u Vec3./ int2Float image_width
  let pixel_delta_v = viewport_v Vec3./ int2Float image_height

  let viewport_upper_left = camera_center - (Vec3 0 0 focal_length) - (viewport_u Vec3./ 2) - (viewport_v Vec3./ 2)
  let pixel00_loc = viewport_upper_left + ((pixel_delta_u + pixel_delta_v) Vec3./ 2)

  let caminfo = CamInfo camera_center pixel00_loc pixel_delta_u pixel_delta_v

  let pixels = pixelArray caminfo image_width image_height
  let output = "P3\n" ++ show image_width ++ " " ++ show image_height ++ "\n255\n" ++ printPixels pixels
  writeFile "output.ppm" output
