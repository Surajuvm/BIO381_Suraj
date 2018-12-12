# sunburstR
# november 29, 2018
# EAS

# a great way to summarize and view observational data not based on numbers but letters and words

# it tracks and graphs patterns in an interactive graph

library(ggplot2)
library(sunburstR)
library(magrittr)
library(dplyr)

# data should be .csv or data frame

# first import your data from a csv file or data frame

data <- read.csv("sunburstData.csv", header = T, colClasses = c("integer", "character"))

head(data)
typeof(data)

action <- data %>%
  group_by(Time_tag) %>%
  #filter(row_number()==1) %>%
  #ungroup() %>%
  summarize(Response=paste(c(Response), collapse = "-"))
# results in length 1 character vector 

sequences <- action %>%
  ungroup() %>%
  group_by(Response) %>%
  summarize(count=n())

sequences$depth <- unlist(lapply(strsplit(sequences$Response, "-"), length))

# lappy returns a list of the same length of x, so we worked with our times before, now we are working with our responses 
# strsplit splits the elements of our character vector into substrings

sb <- sequences %>%
  arrange(desc(depth), Response) %>%
  sunburst(count = TRUE)
print(sb)

# the 8 in the center means there are 8 different combinations of observations in our data

# for example, in the upper right of the sunburst with the sequence of absent bottm and dead, 1 of 8 or 12.5% of the combinations in my data have these three elements 


