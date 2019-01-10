-- File Name: problem5.hs
-- Author: Hongyi Xue
-- Class: CMPT 340

split :: [a] -> Int -> ([a],[a])
split [] a = ([],[])
split (x:xs) a = ((take a (x:xs)),(drop a (x:xs)))
