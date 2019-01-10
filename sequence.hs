-- File Name: sequence.hs
-- If N is odd, the next integer is 3N+1
-- If N is even, the next integer is N/2
-- If N is 1, the sequence is finished


length1 :: Int -> Int
length1 n = if      ( n == 1 )          then 1
            else if ( n `mod` 2 == 0 )  then length1 ( n `div` 2 ) + 1
            else                             length1 ( 3 * n + 1 ) + 1



length2 :: Int -> Int
length2 n | n == 1             = 1
          | ( n `mod` 2 == 0)  = length2 ( n `div` 2 ) + 1
          | otherwise          = length2 ( 3 * n + 1 ) + 1



length3 :: Int -> Int
length3 1 = 1
length3 n = oddOrEven ( n `mod` 2)
        where oddOrEven 0 = length3 (n `div` 2) + 1
              oddOrEven 1 = length3 (3 * n + 1) + 1




