-- problem1
-- sudent: Hongyi Xue
-- NSID: hox294
-- course: 340

-- A function called 'unfold' that takes in
-- the judging statement that applies onto the input list
-- two functions
-- one list
-- return the new list after operation

unfold :: ([a]->Bool) -> ([a]->a) -> ([a]->[a]) -> [a] -> [a]
unfold p h t x | p x       = []
               | otherwise = h x: unfold p h t (t x)

-- myMap has same functionality as Prelude.map

myMap :: Eq a =>(a -> a) -> [a] -> [a]
myMap f []    = []
myMap f x     = unfold (==[]) (f.head) (tail) x

--myIterate creates a list of[x, fx f(fx)...] til the last item is larger than 100

myIterate :: Eq a =>(a -> a) -> [a] -> [a]
myIterate f x = unfold (==[]) head (unfold (==[]) (f.head) (tail)) x

