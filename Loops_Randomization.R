myVec <- rpois(10,1) # possion distribution with lambda of 1
print(myVec)
counter <- 0
for(i in seq_along(myVec)){
  if(myVec[i]==0)
    counter <- counter+1
  
}
print(counter)

myZero <- sum(myVec == 0)
print(myZero)


###############
# FUNCTION: MatrixMaker
# INPUTS: two integers (x and y) representing the number of rows and columns of a matrix m
# OUTPUTS: matrix of x*y dimension
#------------------------
xVar <- 5
yVar <- 7
MatrixMaker <- function(x = floor(xVar), y = floor(yVar)){
  m <- matrix(nrow = x, ncol = y)
  for(i in 1:nrow(m)) {
    for(j in 1:ncol(m)) {
      m[i,j] <- i*j
    } # close j loop
  } # close i loop
  return(print(m))
}  
MatrixMaker()
MatrixMaker(2,3)

library(ggplot2)
library(TeachingDemos)

# char2seed("Autumn Leaves") 

# function readData
readData <- function(z=NULL) {
  if(is.null(z)){
    xObs <- 1:20
    yObs <- xObs + 10*rnorm(20)
    dF <- data.frame(ID=seq_along(xObs),
                     xObs,
                     yObs)} else {
                       dF <- read.table(file=z, row.names = 1, header = TRUE, sep = ",", stringsAsFactors = FALSE)}
  return(dF)
}
readData()

# Calculate the matrix
getMetric <- function(z=NULL){
  if(is.null(z)){
    xObs <- 1:20
    yObs <- xObs + 10*rnorm(20)
    z <- data.frame(ID=seq_along(xObs), xObs, yObs)}
  . <- lm(z[,3]~z[,2]) # . used as a temporary variable
  . <- summary(.)
  . <- .$coefficients[2,1]
  slope <- . 
  return(slope)
}
getMetric()  

# create randomization 
shuffleData <- function(z=NULL) {
  if(is.null(z)){
    xObs <- 1:20
    yObs <- xObs + 10*rnorm(20)
    z <- data.frame(ID=seq_along(xObs), xObs, yObs)}
  z[,3] <- sample(z[,3])
  return(z)
}
shuffleData()