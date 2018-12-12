# Popbio
# December 4, 2018
# CU

# uses matrix population models to estimate a populations vital rates and build projection matrices

# plant systems

# takes a leslie matrix or transitions matrix (A) and population vector (n)

# contains function that give you predictions about how population is expected to change and what life stages have treater effects (sensativities and elasticites) on population 

library(popbio)

# plantina a rose garden

stages <- c("seed", "juvenile", "flowering")
A <- matrix(c(0.5, 0, 50, 0.1, 0.2, 0, 0, 0.6, 0.9), nrow = 3, byrow = T, dimnames = list(stages,stages))

A
n <- c(0,0,10)
n
p <- pop.projection(A, n, iterations=15)

# takes in A and n, to get number of individuals after 1 year (t + 1), does over and over again (iterations) until stable stage distribution is met

p

stage.vector.plot(p$stage.vectors, col = 2:4)

eigA <- eigen.analysis(A)
eigA
eigA$elasticities # elasticity matrix tells you effect of change in vital rate has an lambda - more sensative elements have higher values, cause largest change in lambda

swampyA <- A
swampyA[2,1] <- 0.05
p2 <- pop.projection(swampyA, n, iterations = 15)
p2

eigSwampy <- eigen.analysis(swampyA)
eigSwampy

# swampy and shady
shadyA <- swampyA 
shadyA[3,2] <- 0.1

p3 <- pop.projection(shadyA, n, iterations = 15)
p3



