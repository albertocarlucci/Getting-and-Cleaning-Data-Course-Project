# Getting and Cleaning Data Course Project

# You should create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# load libraries
library(dplyr)
library(tidyr)

# Download and unzip data for the project
dataurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "UCI HAR Dataset.zip"
downloaddirectory <- "UCI HAR Dataset"

if(!file.exists(zipfile)) {
        download.file(dataurl, destfile = zipfile, method = "curl")
        downloadtime <- Sys.time()
}

if(!file.exists(downloaddirectory)) {
        unzip(zipfile)
}

# Read txt files test set
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")

# Read txt files train set
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")

# Task 1: Merges the training and the test sets to create one data set.
# Merge datasets from test and train:
# subject txt files: are the subjects who performed activity test&train
# X txt files: contains Data Sets test&train
# y txt files: contains Labels test&train

# Merge Test & Train data in one table
allsubjects <- rbind(subjecttrain,subjecttest)
alldata <- rbind(xtest,xtrain)
alllabels <- rbind(ytest,ytrain)

# Task 2: extracts only the measurements on the mean and standard deviation for each measurement.
# From the description from 'featues_info.txt':
# mean(): Mean value
# std(): Standard deviation
features <- read.table("./UCI HAR Dataset/features.txt")
# search for expressions in the 2nd column of 'features' with either "mean" or "std"
meanstdcols <- grep("(.*)mean|std(.*)",features[,2])
# rename column names of alldata dropping 'V'
colnames(alldata) <- c(1:561)
# select columns from alldata that are in meanstdcols (only mean and std variables)
meanstdonly <- select(alldata,all_of(meanstdcols))

# Task 3: Uses descriptive activity names to name the activities in the data set
# Read activity labels from txt file
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
# Merge labels and label descriptions, keeping only the "Activity Name" column
describedactivities <- left_join(alllabels, activitylabels, by="V1") 
colnames(describedactivities) <- c("Activity_ID","Activity Name") 
describedactivities <- describedactivities[,"Activity Name"]

# Task 4: Appropriately labels the data set with descriptive variable names.
# Take the features, transform them as a vector to pass it later as labels for the dataset
descriptivelabels <- features[meanstdcols,2]
descriptivelabels <- as.vector(descriptivelabels)
# Substitute some abbreviations in the labels to make it easier to understand
descriptivelabels <- sub("mean\\(\\)","Mean",descriptivelabels)
descriptivelabels <- sub("std\\(\\)","StdDev",descriptivelabels)
descriptivelabels <- sub("^f","Frequency-",descriptivelabels)
descriptivelabels <- sub("^t","Time-",descriptivelabels)
descriptivelabels <- sub("Acc","-Accelerometer-",descriptivelabels)
descriptivelabels <- sub("Gyro","-Gyroscope-",descriptivelabels)
# Pass the transformed labels to "Means" and "Standard Deviation" only dataset
names(meanstdonly) <- descriptivelabels
# Merge Subject, Described Activities and (Mean and Std only) Dataset 
names(allsubjects) <- "Subject"
datasetfinal <- cbind(allsubjects, describedactivities,meanstdonly)%>% rename(Activity = describedactivities)

# Task 5: From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.         
newdataset <- datasetfinal %>% group_by(Subject, Activity) %>% summarize_if(is.numeric,mean)


