-- File Name: problem7.hs
-- Author: Hongyi Xue
-- Class: CMPT 340

consecutive :: [Char] -> Int
consecutive []    = 0
consecutive list1 = count list1 [1] 1

count :: [Char] -> [Int] -> Int -> Int
count [] (y:ys) record                      = maximum (y:ys)
count (x:xs) (y:ys) record                  = if (xs == [])               then count (xs) (y:ys) 1
                                              else if (x == (head (xs)))  then count (xs) ((y:ys)++[(record+1)]) (record +1)
                                              else                             count (xs) (y:ys) 1
