### Himanshu Chheda ; 19th November 2017
## Data wrangling script for logistic regression analysis

# Read both student-mat.csv and student-por.csv into R
setwd("~/Documents/GitHub/IODS-project/data/")
math <- read.csv("student-mat.csv", header = T, sep = ";")
por <- read.csv("student-por.csv", header = T, sep = ";")

# explore the structure and dimensions of the data
str(math)
str(por)
dim(math)
dim(por)

# Join the two data sets using the variables "school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet" as (student) identifiers. Keep only the students present in both data sets. Explore the structure and dimensions of the joined data.
library(dplyr)
# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(math, por, by = join_by, suffix = c("_m", "_p"))
str(math_por)
dim(math_por)

# Either a) copy the solution from the DataCamp exercise The if-else structure to combine the 'duplicated' answers in the joined data, or b) write your own solution to achieve this task. (1 point)
alc <- select(math_por, one_of(join_by))
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]
# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# Take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use' to the joined data. Then use 'alc_use' to create a new logical column 'high_use' which is TRUE for students for which 'alc_use' is greater than 2 (and FALSE otherwise). (1 point)
alc$alc_use <- (alc$Dalc + alc$Walc)/2
alc <- mutate(alc, high_use = alc_use > 2)
dim(alc)
str(alc)

# Glimpse at the joined and modified data to make sure everything is in order. The joined data should now have 382 observations of 35 variables. Save the joined and modified data set to the ‘data’ folder, using for example write.csv() or write.table() functions. (1 point)
write.table(alc, "alcohol_consumption.txt", sep = "\t", row.names = F, quote = F)