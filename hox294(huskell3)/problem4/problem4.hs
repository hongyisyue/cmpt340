-- File Name: problem4.hs
-- averageThree: return the average of 3 integers
-- averageThreeInOne: receives 3 integers as a triple rather than separately
-- orderTriple: accept a triple of integers as input, apearing in ascending order
-- howManyAboveAverage: return how many of 3 integers are larger than their average


averageThree :: Int -> Int -> Int -> Int
averageThree a b c = ( a + b + c ) `div` 3



averageThreeInOne :: (Int, Int, Int) -> Int
averageThreeInOne (a, b, c) = averageThree a b c



orderTriple :: (Int, Int, Int) -> (Int, Int, Int)
orderTriple (a, b, c) = if        (a>b && (b>c || b==c))               then (c, b, a)
                        else if   ((a>c && c>b) || (a>b && a==c))      then (b, c, a)
                        else if   ((b>a && a>c) || (b>c && a==b))      then (c, a, b)
                        else if   (b>c && (c>a || a==c))               then (a, c, b)
                        else if   (c>a && (a>b || a==b))               then (b, a, c)
                        else if   (howManyAboveAverage (a, b, c))      then (a, b, c)
                        else                                                (a, b, c)

                        where howManyAboveAverage n = (a==b && b==c)


howManyAboveAverage :: (Int, Int, Int) -> Int
howManyAboveAverage (a, b, c) = if         ((a+b+c)-maximum[a, b, c]-minimum[a, b, c] > averageThree a b c)      then 2
                                else if    (a==b && b==c)                                                        then 0
                                else                                                                                  1
