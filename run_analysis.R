#Download file
filename <- "Data Cleaning Project"
if(!file.exists(filename)){download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",filename)}
unzip(filename)

#change the working directory to access the files
setwd("~/UCI HAR Dataset")

#get the required colums containing mean and std
required_cols <- read.table("features.txt")
required_cols <- required_cols[grepl("ean|td",required_cols[,2]),]
required_cols_no <- required_cols[,1]
activity_labels <- read.table("activity_labels.txt")
names(activity_labels)<-c("No","Activity")

# change the working directory to access 'test' files
setwd("~/UCI HAR Dataset/test")

#collect the required columns and name them properly

test_data <- read.table("X_test.txt")
test_data <- test_data[,required_cols_no]
names(test_data)<-required_cols[,2]
#collect subjects,activity and append
subject <- read.table("subject_test.txt")
names(subject)<-"Subject"
activity <- read.table("y_test.txt")
activity[,1]<-activity_labels[activity[,1],2]
names(activity)<-"Activity"
test_data <- cbind(test_data,activity,subject)

# change the working directory to access 'train' files
setwd("~/UCI HAR Dataset/train")

#collect the required columns and name them properly
train_data <- read.table("X_train.txt")
train_data <- train_data[,required_cols_no]
names(train_data)<-required_cols[,2]
#collect subjects,activity and append
subject <- read.table("subject_train.txt")
names(subject)<-"Subject"
activity <- read.table("y_train.txt")
activity[,1]<-activity_labels[activity[,1],2]
names(activity)<-"Activity"
train_data <- cbind(train_data,activity,subject)

#get both train and test data in the same data frame
merged_data <- rbind(train_data,test_data) 

#install the required package to melt and decast the data frame
install.packages("data.table")
library(data.table)
# melt and dcast the merged data to get the required dataset
merged_data <- data.table(merged_data)
merged_data <- melt(merged_data,id=c("Activity","Subject"))
merged_data <- dcast(merged_data,Activity+Subject~variable,fun = mean)
write.table(merged_data,row.names = FALSE)
