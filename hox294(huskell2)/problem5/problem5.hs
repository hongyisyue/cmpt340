-- problem5
-- student: Hongyi Xue
-- NSID: hox294
-- course: cmpt340

perfect :: [Integer]
perfect = [n|n <- [2 ..] , n == sum [i|i<- [1,2 .. n-1], n `mod` i == 0]]
