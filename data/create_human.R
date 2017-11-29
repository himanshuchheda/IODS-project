
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

str(hd)
dim(hd)

str(gii)
dim(gii)

summary(hd)
summary(gii)

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