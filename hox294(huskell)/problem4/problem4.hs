-- File Name: problem4.hs
-- Author: Hongyi Xue
-- Class: CMPT 340

shuffle :: [a] -> [a] -> [a]
shuffle = merge
    where merge :: [a] -> [a] -> [a]
          merge xs [] = xs
          merge [] ys = ys
          merge (x:xs) (y:ys) = x : y : merge xs ys
