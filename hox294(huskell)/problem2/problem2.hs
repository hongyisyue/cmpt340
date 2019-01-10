-- File Name: program.hs
-- Author: Hongyi Xue
-- Class: CMPT 340

-- problem2.hs
--  Define the higher-order library function curry that converts a function on pairs into a curried function, and, conversely, the function uncurry that converts a curried function with two arguments into a function on pairs.

curry1 :: ((a,b) -> c) -> (a -> b -> c)
curry1 f \x y -> f (x, y)


uncurry1 :: (a -> b -> c) -> ((a, b) -> c)
uncurry1 f \(x, y) -> f x y
