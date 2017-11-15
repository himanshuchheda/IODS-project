# Himanshu Chheda 2017/11/14 Wrangling the data file #
data_file <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header = T, sep = "\t")
str(data_file)
dim(data_file)

# The file contains 183 rows and 60 columns; All the columns, except the gender column are integers. The gender column is a factor

# Loading the library dplyr
library(dplyr)

# As attitude column is a sum of 10 questions, reversing it back to the original scale of 1-5
data_file$attitude <- data_file$Attitude/10

# All deep learning related questions
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")

# All surface learning related questions
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")

# All strategic learning related questions
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# Creating the average scores for each of the 3 fields
deep_columns <- select(data_file, one_of(deep_questions))
data_file$deep <- rowMeans(deep_columns)

surface_columns <- select(data_file, one_of(surface_questions))
data_file$surf <- rowMeans(surface_columns)

strategic_columns <- select(data_file, one_of(strategic_questions))
data_file$stra <- rowMeans(strategic_columns)

# Keeping all the questions required for analysis
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
analysis_data <- select(data_file, one_of(keep_columns))

analysis_data <- analysis_data[analysis_data$Points>0,]
dim(analysis_data)

setwd("~/Documents/GitHub/IODS-project/")
write.table(analysis_data, "~/Documents/GitHub/IODS-project/data/learning2014.txt", quote = F, row.names = F, sep = "\t")

learning2014 <- read.table("~/Documents/GitHub/IODS-project/data/learning2014.txt", header = T, sep = "\t")
head(learning2014)

str(learning2014)
