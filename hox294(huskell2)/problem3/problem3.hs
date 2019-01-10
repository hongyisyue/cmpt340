-- problem3
-- student: Hongyi Xue
-- NSID: hox294
-- course: cmpt340


luhnDouble :: Integer -> Integer
luhnDouble x | 2*x <= 9   = 2*x
             | otherwise  = 2*x - 9

luhn :: [Integer] -> Bool
luhn [d, c, b, a] | (sum (altMap luhnDouble (+0) [d,c,b,a])) `mod` 10 == 0     = True
             | otherwise                  = False

altMap :: (Integer -> Integer) -> (Integer -> Integer) -> [Integer] -> [Integer]
altMap f g [] = []
altMap f g (x:y:xs) | (x:y:xs)==[]   = (x:y:xs)
                    | otherwise      = ((f x) : (g y) : (altMap f g xs))
