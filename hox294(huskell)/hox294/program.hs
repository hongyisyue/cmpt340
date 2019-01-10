-- File Name: program.hs
-- Author: Hongyi Xue
-- Class: CMPT 340


-- problem2.hs
--  Define the higher-order library function curry that converts a function on pairs into a curried function, and, conversely, the function uncurry that converts a curried function with two arguments into a function on pairs.

curry1 :: ((a,b) -> c) -> (a -> b -> c)
curry1 f = \x y -> f (x, y)


uncurry1 :: (a -> b -> c) -> ((a, b) -> c)
uncurry1 f = \(x, y) -> f x y


-- problem3
-- Author: Hongyi Xue
-- Class: CMPT 340

-- Define type mantissa and exponent
type Mant = Int
type Expo = Int

-- Define a new MyFloat data type
data MyFloat = MyFloat Mant Expo

instance Show MyFloat where
    show (MyFloat a b) = "(MyFloat " ++ (show a) ++ " " ++ (show b) ++ ")"

-- Define *, /, +, -, neg, <=, >=, <, >. == for MyFloat
instance Eq MyFloat where
    (==) = myFloatEquality

myFloatEquality :: MyFloat -> MyFloat -> Bool
myFloatEquality (MyFloat a b) (MyFloat c d) = ((removeZero a)==(removeZero c) && b==d)

instance Ord MyFloat where
    (>) = myFloatLarger
    (<) = myFloatSmaller
    (>=) = myFloatLE
    (<=) = myFloatSE


myFloatLarger :: MyFloat -> MyFloat -> Bool
myFloatLarger (MyFloat a b) (MyFloat c d) = if       (b > d)                                                then True
                                            else if  (b == d && (removeZero a) > (removeZero c))            then True
                                            else                                                                 False


myFloatSmaller :: MyFloat -> MyFloat -> Bool
myFloatSmaller (MyFloat a b) (MyFloat c d) = if       (b < d)                                                then True
                                             else if  (b == d && (removeZero a) < (removeZero c))            then True
                                             else                                                                 False


myFloatLE :: MyFloat -> MyFloat -> Bool
myFloatLE (MyFloat a b) (MyFloat c d) = if        (myFloatLarger (MyFloat a b) (MyFloat c d))    then True
                                        else if   (myFloatEquality (MyFloat a b) (MyFloat c d))  then True
                                        else                                                          False


myFloatSE :: MyFloat -> MyFloat -> Bool
myFloatSE (MyFloat a b) (MyFloat c d) = if        (myFloatSmaller (MyFloat a b) (MyFloat c d))    then True
                                        else if   (myFloatEquality (MyFloat a b) (MyFloat c d))   then True
                                        else                                                             False

instance Num MyFloat where
    (-) = myFloatMis
    (+) = myFloatPls
    (*) = myFloatMul
    (negate) (MyFloat a b)= myFloatNeg (MyFloat a b)

myFloatMis :: MyFloat -> MyFloat -> MyFloat
myFloatMis (MyFloat a b) (MyFloat c d) = if  (b >= d)     then (MyFloat (floor (unflow(fromIntegral(((removeZero a) * 10^(difference(a,b))) - (removeZero c) * 10^(difference(c,d)))))) (b-((maximum [(howMany ((removeZero a)* 10^(difference(a,b))) 1),(howMany ((removeZero c)* 10^(difference(c,d))) 1)])-(howMany (floor (unflow(fromIntegral(((removeZero a) * 10^(difference(a,b))) - (removeZero c) * 10^(difference(c,d)))))) 1))))
                                         else                  (MyFloat (floor (unflow(fromIntegral(((removeZero a) * 10^(difference(a,b))) - (removeZero c) * 10^(difference(c,d)))))) (d-((maximum [(howMany ((removeZero a)* 10^(difference(a,b))) 1),(howMany ((removeZero c)* 10^(difference(c,d))) 1)])-(howMany (floor (unflow(fromIntegral(((removeZero a) * 10^(difference(a,b))) - (removeZero c) * 10^(difference(c,d)))))) 1))))

myFloatPls :: MyFloat -> MyFloat -> MyFloat
myFloatPls (MyFloat a b) (MyFloat c d) = if       (b == d)    then (MyFloat (floor (unflow((flow (fromIntegral a))+(flow (fromIntegral c))))) (b+(howMany (floor (unflow((flow (fromIntegral a))+(flow (fromIntegral c))))) 1)-(maximum [(howMany (removeZero a) 1),(howMany (removeZero c) 1)])))
                                         else if  (b > d)     then (MyFloat (floor (unflow(fromIntegral(((removeZero a) * 10^(difference(a,b))) + (removeZero c) * 10^(difference(c,d)))))) b)
                                         else                      (MyFloat (floor (unflow(fromIntegral(((removeZero a) * 10^(difference(a,b))) + (removeZero c) * 10^(difference(c,d)))))) d)

myFloatMul :: MyFloat -> MyFloat -> MyFloat
myFloatMul (MyFloat a b) (MyFloat c d) = (MyFloat ((removeZero a)*(removeZero c)) ((howMany ((removeZero a)*(removeZero c)) 1) + (difference ((removeZero a), b))+ (difference ((removeZero c), d))))

myFloatNeg :: MyFloat -> MyFloat
myFloatNeg (MyFloat a b) = (MyFloat (-a) b)


instance Fractional MyFloat where
    (/) = myFloatDiv

myFloatDiv :: MyFloat -> MyFloat -> MyFloat
myFloatDiv (MyFloat a b) (MyFloat c d) = if (floor (fromIntegral (a `div` c)) == 0)   then (MyFloat (round (unflow (fromIntegral (a `div` c)))) (difference(a, b)- difference(c, d)))
                                         else                                              (MyFloat (round (unflow (fromIntegral (a `div` c)))) ((howMany (a `div` c) 1)+ (difference ((removeZero a), b)) - (difference ((removeZero c), d)) ))

difference :: (Int, Int) -> Int
difference (a, b) = b - howMany a 1

howMany :: Int -> Int -> Int
howMany n bits = if ((n `div` 10) < 1)  then bits
                 else                        howMany (n `div` 10) (bits+1)

-- Remove zeros at the end of mantissa
removeZero :: Int -> Int
removeZero n = if (n == 0)                then 0
               else if (n `mod` 10 == 0)  then removeZero (n `div` 10)
               else                            n

whole :: MyFloat -> Int
whole (MyFloat a b) = floor ( (flow (fromIntegral a)) * 10^(b) )

fraction :: MyFloat -> Double
fraction (MyFloat a b) = ( (flow (fromIntegral a)) * 10^(b) )- (fromIntegral (floor ( (flow (fromIntegral a)) * 10^(b) )))

flow :: Double -> Double
flow a = until (<1) (/10) a

isInt x = x == fromInteger (round x)

unflow a = until (isInt) (*10) a


-- problem4
-- Author: Hongyi Xue
-- Class: CMPT 340

shuffle :: [a] -> [a] -> [a]
shuffle = merge
    where merge :: [a] -> [a] -> [a]
          merge xs [] = xs
          merge [] ys = ys
          merge (x:xs) (y:ys) = x : y : merge xs ys


-- problem5
-- Author: Hongyi Xue
-- Class: CMPT 340

split :: [a] -> Int -> ([a],[a])
split [] a = ([],[])
split (x:xs) a = ((take a (x:xs)),(drop a (x:xs)))


-- problem6
-- Author: Hongyi Xue
-- Class: CMPT 340

nshuffle :: Int -> Int -> [Char]
nshuffle c n = shuffleHelper n c ((take c ['b','b' ..]), (take c ['r','r' ..]))
    where shuffleHelper :: Int -> Int -> ([Char], [Char]) -> [Char]
          shuffleHelper n c ((x:xs), (y:ys)) = if (n == 0)   then shuffle (x:xs) (y:ys)
                                               else               shuffleHelper (n-1) c (split (shuffle (x:xs) (y:ys)) c)


-- problem7
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


