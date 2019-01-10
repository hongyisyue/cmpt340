-- problem4
-- student: Hongyi Xue
-- NSID: hox294
-- course: cmpt340

myPair :: [Integer]-> [Integer] -> [(Integer, Integer)]
myPair (x:xs) (y:ys) = concat [[(x,y)|x<-(x:xs)]|y<-(y:ys)]
