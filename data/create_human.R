#### Himanshu Chheda
## 6/12/2017, Happy Indpendence day Finland :)

# Loading the library dplyr
library(dplyr)
library(stringr)

# Reading in the files
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Exploring the structure and the dimensionality of the data
str(hd)
dim(hd)

str(gii)
dim(gii)

summary(hd)
summary(gii)

# Renaming the columns
names(hd)[3] <- "HDI"
names(hd)[4] <- "LifeExpec" 
names(hd)[5] <- "ExpecYoEdu"
names(hd)[6] <- "MeanYoEdu"
names(hd)[7] <- "GNIpc"
names(hd)[8] <- "GNIRank-HDIRank"

names(gii)[3] <- "GII"
names(gii)[4] <- "MMR"
names(gii)[5] <- "ABR"
names(gii)[6] <- "PCinPar"
names(gii)[7] <- "PSeF"
names(gii)[8] <- "PSeM"
names(gii)[9] <- "LFPRF"
names(gii)[10] <- "LFPRM"

# Mutating the Gender inequality dataset
gii$Ratedu <- gii$PSeF/gii$PSeM
gii$RatLFP <- gii$LFPRF/gii$LFPRM

# Joining the 2 datasets
human <- inner_join(hd, gii, by = "Country")

# Writing the dataframe to a file
write.table(human, "~/Documents/GitHub/IODS-project/data/human.txt", row.names = F, quote = F, sep = "\t")
dim(human)
human$GNIpc <- str_replace(human$GNIpc, pattern = ",", replace = "") %>% as.numeric()

human <- human %>% select("Country", "Ratedu", "RatLFP", "ExpecYoEdu", "LifeExpec", "GNIpc", "MMR", "ABR", "PCinPar")
names(human) <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- human[complete.cases(human),]
last <- nrow(human)-7
human_ <- human[1:last,]
rownames(human_) <- human_$Country
human_ <- human_ %>% select(-c(Country))

write.table(human_, "~/Documents/GitHub/IODS-project/data/human.txt", row.names = T, sep = "\t")
