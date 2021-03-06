
###############
# FUNCTION: Get Data
# INPUTS: .csv data file
# OUTPUTS: data frame
#------------------------
getData <- function(fileName=NULL){
  if(is.null(fileName)){
    dataFrame <- data.frame(ID=1:20, 
                            varA=runif(20),
                            varB=runif(20))
  } else {
    dataFrame <- read.table(file=fileName, 
                            header = TRUE, 
                            sep = ",",
                            stringsAsFactors = FALSE)
  }
  
  
  
  
  return(dataFrame)
}
getData()
#------------------------

###############
# FUNCTION: fitRegressionModel
# fits an ols regression model
# INPUTS: x and y vectors of numeric. must be same length
# OUTPUTS: entire summary from lm
#------------------------
fitRegressionModel <- function(xVar=runif(20), yVar=runif(20)) {
  dataFrame <- data.frame(xVar, yVar)
  regModel <- lm(yVar~xVar, data=dataFrame)
  return(summary(regModel))
}
fitRegressionModel()

#------------------------

###############
# FUNCTION: summarize output
# INPUTS: summary from linear model
# OUTPUTS: vector of residuals
#------------------------
summarizeOutput <- function(z=NULL){
  if(is.null(z)) {
    z <- summary(lm(runif(20)~runif(20)))}
  return(z$residuals)
}
summarizeOutput()
#------------------------

###############
# FUNCTION: graph results
# INPUTS: x and y numeric vectors
# OUTPUTS:creates graph (side effect)
#------------------------
graphResults <- function(xVar=runif(20),
                         yVar=runif(20)){
  library(ggplot2)
  dataFrame <- data.frame(xVar,yVar)
  p1 <- qplot(data=dataFrame,
              x=xVar, y=yVar,
              geom=c("smooth", "point"))
  print(p1)
  
}
graphResults()
#------------------------
# fitRegressionModel()
# summarizeOutput()
# getData()
# graphResults()

