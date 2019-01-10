-- File Name: problem3.hs
-- luhnDouble: double a digit and substracts 9 if greater than 9
-- luhn: define if a 4-digit bank card is valid


luhnDouble :: Int -> Int
luhnDouble n | 2*n > 9       = (2*n-9)
             | otherwise     = 2*n



luhn :: Int -> Int -> Int -> Int -> String
luhn a b c d = if ((luhnDouble b + luhnDouble c + luhnDouble d) `mod` 10 == 0)   then "True"
               else                                                                   "False"



