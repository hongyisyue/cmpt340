-- File Name: problem5.hs
-- compose3: takes 3 functions f(x), g(x), h(x); evaluates to a function to compute f(g(h(x)))


f x = x*5
g x = x*1
h x = x+0.5



compose3 :: Double -> Double
compose3 x = f(g(h(x)))
