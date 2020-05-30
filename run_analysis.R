# Getting and Cleaning Data Course Project

# Review Criteria
# 1. The submitted data set is tidy.
# 2. The Github repo contains the required scripts.
# 3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
# 4. The README that explains the analysis files is clear and understandable.
# 5. The work submitted for this project is the work of the student who submitted it.


# Purpose
# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.
# The goal is to prepare tidy data that can be used for later analysis.
# You will be graded by your peers on a series of yes/no questions related to the project.
# You will be required to submit:
# 1) a tidy data set as described below,
# 2) a link to a Github repository with your script for performing the analysis, and
# 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.
# You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.


#Description
# One of the most exciting areas in all of data science right now is wearable computing. 
# Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.
# The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.
# A full description is available at the site where the data was obtained:

# Task
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

# Create Data Frame tbl (optional, personal preference to work with)
tbl_df(subjecttest)
tbl_df(xtest)
tbl_df(ytest)

tbl_df(subjecttrain)
tbl_df(xtrain)
tbl_df(ytrain)










