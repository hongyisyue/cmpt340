-- problem2
-- sudent: Hongyi Xue
-- NSID: hox294
-- course: 340

altMap :: (Integer -> Integer) -> (Integer -> Integer) -> [Integer] -> [Integer]
altMap f g [] = []
altMap f g (x:y:xs) | (x:y:xs)==[]        = (x:y:xs)
                    | length xs ==1       = ((f x) : (g y) : [f (head xs)])
                    | otherwise           = ((f x) : (g y) : (altMap f g xs))
