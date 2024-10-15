set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2

###remove NAs ---

prob1 <- hw2[!is.na(hw2)]
prob1

###select all numbers btwn 14 and 38

prob1 <- prob1[prob1 > 14 & prob1 < 38]
prob1

###multiply each number by 3

times3 <-prob1 * 3
times3

###add 10

plus10 <-times3 + 10
plus10

###select every other number

final <- plus10[c(TRUE,FALSE)]
final









