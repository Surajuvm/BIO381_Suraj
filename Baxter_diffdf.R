# diffdf package
# 11/28/18
# BWW

# a package for comparing dataframes
library(diffdf)
library(tidyverse)

x <- presidential
x

y <- x

y[10,1] <- "Gore"
y[10,4] <- "Democratic"

# check to see if two data sets differ
diffdf(x,y)

# take 2 rows out of x
y <- head(x, nrow(x) -2)

diffdf(x,y)

# what if files sorted differently 
y <- arrange(x, name)

diffdf(x,y)

# use keys=to clear up issues with sorting
diffdf(x,y, keys = "start")

# get rows with differences
y <- x
y[10,1] <- "Gore"
y[10,4] <- "Democratic"

xyDiff <- diffdf(x,y)

wrongRow <- diffdf_issuerows(y, xyDiff)
wrongRow

rightRow <- diffdf_issuerows(x, xyDiff)
rightRow

y[10,] <- rightRow
y

# simulate data
pos <- tibble(ID=LETTERS, val=runif(26))
neg <- pos

# change 3 alues in neg
neg[1:3,2] <- neg[1:3,2] * 1.25

# function to check IDs and graph differing values

graphDiff <- function(a,b){
  # check IDs
  idDiff <- diffdf(a[,1], b[,1], keys = "ID", suppress_warnings = TRUE)
  if(diffdf_has_issues(idDiff)) {
    print("Inputs don't have same IDs")
  }else{
    # look for values that are different 
    valDiff <- diffdf(a,b, keys = "ID", suppress_warnings = TRUE)
    # make a tibble of rows that differ
    diffA <- diffdf_issuerows(a, valDiff)
    diffA$treatment <- rep("Pos", nrow(diffA))
    diffB <- diffdf_issuerows(b, valDiff)
    diffB$treatment <- rep("Neg", nrow(diffB))
    diffBoth <- as.tibble(rbind(diffA, diffB))
    
    # graph (double bar)
    p1 <- ggplot(data=diffBoth, mapping = aes(x=ID, y=val, fill = treatment)) +
      geom_bar(position = "dodge", stat = "identity")
   print(p1)
  }
}
    

graphDiff(pos,neg)


