#You should create one R script called run_analysis.R that does the following. 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

setwd("C:/Users/JtopTosh1/Downloads/UCI HAR Dataset/")
features <- read.table("features.txt")
feats <- as.vector(features$V2)
slots <- grep("mean|Mean|std|Std", features$V2) #extract only mean and sd
features$V2[slots]

obs<-1:2947
xtest<-read.table("test/X_test.txt")
names(xtest)<-feats
xtest<-xtest[slots]
ytest<-read.table("test/Y_test.txt")
subject<-read.table("test/subject_test.txt")
dim(unique(subject))

a<-cbind(obs, xtest)
b<-cbind(obs, ytest)
c<-cbind(obs, subject)

names(b)<-c("obs", "activity")
names(c)<-c("obs", "id")

test <- merge(b,a, by.x="obs", by.y="obs")
test1 <- merge(c,test, by.x="obs", by.y="obs")
# head(test1[1:5], 500)

dim(test)

obs<-1:7352
xtrain<-read.table("train/X_train.txt")
names(xtrain)<-feats
xtrain<-xtrain[slots]
ytrain<-read.table("train/Y_train.txt")
subjec<-read.table("train/subject_train.txt")
dim(unique(subjec))

d<-cbind(obs, xtrain)
e<-cbind(obs, ytrain)
f<-cbind(obs, subjec)
names(e)<-c("obs", "activity")
names(f)<-c("obs", "id")

test2 <- merge(e,d, by.x="obs", by.y="obs")
test3 <- merge(f,test2, by.x="obs", by.y="obs")

# install.packages("dplyr")
library(plyr)
library(dplyr)

# merge test and train
length(intersect(names(test1), names(test3))) #89 variables including obs,id,activity
head(intersect(names(test1), names(test3)))

merged = merge(test1, test3, all=TRUE)
merged <- select(merged, -obs)

# install.packages("reshape")
library(reshape)
library(reshape2)

attach(merged)
merged$act[activity==1] <- "1 Walking"
merged$act[activity==2] <- "2 Walking upstairs"
merged$act[activity==3] <- "3 Walking downstairs"
merged$act[activity==4] <- "4 Sitting"
merged$act[activity==5] <- "5 Standing"
merged$act[activity==6] <- "6 Laying"
detach(merged)

merged <- select(merged, -activity)
melts <- melt(merged, id=c("id", "act"))
names(melts) <- c("SubjectID", "Activity", "variable", "value")
tidy <- dcast(melts, SubjectID+Activity~variable, mean, value="value")


write.table(tidy, file="C:/Users/JtopTosh1/Documents/R/tidy.txt", row.names=FALSE)
