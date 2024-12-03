module Vec3 where

import qualified Prelude
import Prelude (Float, Num, Show, abs, signum, fromInteger, Eq)

data Vec3 = Vec3 {x :: Float, y :: Float, z :: Float} deriving (Eq)

instance Num Vec3 where
   (Vec3 a b c) + (Vec3 x_ y_ z_) = Vec3 (a Prelude.+ x_) (b Prelude.+ y_) (c Prelude.+ z_)
   (Vec3 a b c) - (Vec3 x_ y_ z_) = Vec3 (a Prelude.- x_) (b Prelude.- y_) (c Prelude.- z_)
   (Vec3 a b c) * (Vec3 x_ y_ z_) = Vec3 (a Prelude.* x_) (b Prelude.* y_) (c Prelude.* z_)
   abs (Vec3 a b c) = Vec3 (abs a) (abs b) (abs c) 
   signum (Vec3 a b c) = Vec3 (signum a) (signum b) (signum c)
   fromInteger i = Vec3 (fromInteger i) (fromInteger i) (fromInteger i)

scale :: Vec3 -> Float -> Vec3
scale (Vec3 a b c) s = Vec3 (s Prelude.* a) (s Prelude.* b) (s Prelude.* c)

(/) :: Vec3 -> Float -> Vec3
(Vec3 a b c) / d = Vec3 (a Prelude./ d) (b Prelude./ d) (c Prelude./ d)

magnitude :: Vec3 -> Float
magnitude = Prelude.sqrt Prelude.. magnitude_squared

magnitude_squared :: Vec3 -> Float
magnitude_squared (Vec3 a b c) = a Prelude.* a Prelude.+ b Prelude.* b Prelude.+ c Prelude.* c

dot :: Vec3 -> Vec3 -> Float
dot (Vec3 a b c) (Vec3 d e f) = a Prelude.* d Prelude.+ b Prelude.* e Prelude.+ c Prelude.* f

cross :: Vec3 -> Vec3 -> Vec3
cross (Vec3 a b c) (Vec3 d e f) = Vec3 (b Prelude.* f Prelude.- c Prelude.* e) (c Prelude.* d Prelude.- a Prelude.* f) (a Prelude.* e Prelude.- b Prelude.* d)

unit_vector :: Vec3 -> Vec3
unit_vector v = v / magnitude v

instance Show Vec3 where
  show (Vec3 a b c) = Prelude.show (Prelude.round (255.99 Prelude.* a)) Prelude.++ 
    " " Prelude.++ 
    Prelude.show (Prelude.round (255.99 Prelude.* b)) Prelude.++ 
    " " Prelude.++ 
    Prelude.show (Prelude.round (255.99 Prelude.* c)) Prelude.++ "\n"

