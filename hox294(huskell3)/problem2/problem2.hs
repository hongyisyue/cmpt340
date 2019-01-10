-- File Name: problem2.hs
-- If N is odd, n^k=n*n^(k-1)
-- If N is even, n^k=(n^(k/2))^2
-- fastExp1: a conditional expression
-- fastExp2: guarded equations
-- fastExp3: pattern matching


fastExp1 :: Int -> Int -> Int
fastExp1 n k = if      ( n == 1 || k == 0 )      then 1
               else if ( k `mod` 2 == 0 )        then (fastExp1 n (k`div`2))^2
               else                              (fastExp1 n (k-1))* n



fastExp2 :: Int -> Int ->Int
fastExp2 n k | n == 1 || k == 0           = 1
             | ( k `mod` 2 == 0)          = (fastExp2 n (k`div`2))^2
             | otherwise                  = (fastExp2 n (k-1))*n



fastExp3 :: Int -> Int -> Int
fastExp3 n 0 = 1
fastExp3 1 k = 1
fastExp3 n k = oddOrEven ( k `mod` 2)
         where oddOrEven 0 = (fastExp3 n (k `div` 2))^2
               oddOrEven 1 = (fastExp3 n (k - 1))*n




