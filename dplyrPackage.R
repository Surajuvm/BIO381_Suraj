library(dplyr) # loads dplyr library
data(iris) # loads iris dataset
head(iris) # peek first 6 rows of data
dim(iris) # gives the dimension of data, there are 150 rows and 5 columns
any(is.na(iris))# there are no NAs in the dataset 

# Answer 1. There are 150 observations and 5 variables in the iris dataset.
tail(iris)

iris1 <- filter(iris, Species %in% c("versicolor", "virginica"), Sepal.Length > 6, Sepal.Width > 2.5)
head(iris1)
dim(iris1)

# Answer 2. There are 56 observations in the new dataset iris1 containing only versicolor and virginica species of sepal length larger than 6cm and sepal width larger than 2.5 cm.


iris2 <- select(iris1, c(Species, Sepal.Length, Sepal.Width))
head(iris2)
dim(iris2)

# Answer 3. There are 56 observations and 3 variables in the iris2 dataset.

iris3 <- arrange(iris2, desc(Sepal.Length))
head(iris3)

# Answer 4. First six rows of iris3 dataset arranged by Sepal.Length in descending order is shown by head command.

iris4 <- mutate(iris3, Sepal.Area = Sepal.Length * Sepal.Width)
head(iris4)
dim(iris4)

# Answer 5. iris4 dataset contains 56 observations and 4 variables. A new variable Sepal.Area was introduced by mutate function 

iris5 <- summary(iris4)
print(iris5)

# Answer 6. iris5 dataset was created which shows mean of all the variables including sample numbers by using summary function 

iris6G <- group_by(iris4, Species)
iris6 <- summarise(iris6G, count = n(), length = mean(Sepal.Length), width = mean(Sepal.Width))
print(iris6)          

# Answer 7. iris6 dataset shows the mean length and width of each species. Different species were grouped by using group_by function

iris %>%
  filter(Species %in% c("versicolor", "virginica"), Sepal.Length >6, Sepal.Width > 2.5) %>%
  select(c(Species, Sepal.Length, Sepal.Width)) %>%
  arrange(desc(Sepal.Length)) %>%
  mutate(Sepal.Area = Sepal.Length * Sepal.Width) %>%
  group_by(Species) %>%
  summarize(count = n(), length = mean(Sepal.Length), width = mean(Sepal.Width))


# Answer 8. all the manipulations done in a single code chunk using pipe %>%   


  
