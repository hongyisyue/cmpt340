-- File Name: problem6.hs
-- Author: Hongyi Xue
-- Class: CMPT 340

nshuffle :: Int -> Int -> [Char]
nshuffle c n = shuffleHelper n c ((take c ['b','b' ..]), (take c ['r','r' ..]))
    where shuffleHelper :: Int -> Int -> ([Char], [Char]) -> [Char]
          shuffleHelper n c ((x:xs), (y:ys)) = if (n == 0)   then shuffle (x:xs) (y:ys)
                                               else               shuffleHelper (n-1) c (split (shuffle (x:xs) (y:ys)) c)

-- "shuffle" from problem4
shuffle :: [a] -> [a] -> [a]
shuffle = merge
    where merge :: [a] -> [a] -> [a]
          merge xs [] = xs
          merge [] ys = ys
          merge (x:xs) (y:ys) = x : y : merge xs ys

-- "split" from problem5
split :: [a] -> Int -> ([a],[a])
split [] a = ([],[])
split (x:xs) a = ((take a (x:xs)),(drop a (x:xs)))
