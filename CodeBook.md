# Code Book Getting and Cleaning Data
## 4/6/2020 

This code book describes the variables, the data, and any transformations or work that were performed to clean up the data in this project.  

***

### The Data
Data collected from the accelerometers from the Samsung Galaxy S smartphone:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

Full description from UCI Machine Learning Repository:  
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>  

***

### Variables and Transformations for this Project
Following transformations were done to prepair tidy data:  

***

#### Task 1: Merges the training and the test sets to create one data set.
Description of the files:

* "Subject" txt files: are the subjects who performed activity test&train
* "X" txt files: contain Data Sets Test&Train
* "y" txt files: contain Labels Test&Train

Transformations:  
Merged with rbind() Train & Test Data sets in one data frame for each category.

Data frames from Task 1:

* **allsubjects**
* **alldata** 
* **alllabels**

***

#### Task 2: extracts only the measurements on the mean and standard deviation for each measurement.

Description of the relevant data for this specific project in 'featues_info.txt':

* "mean()": Mean value
* "std()": Standard deviation

Transformations:

* 'alldata': column names renamed from 1 to 561 (dropped the "V" from previous names)

Mean and Standard Deviation Data from Task 2:

* **meanstdcols**: vector of integer. Searched for expressions in the 2nd column of 'features.txt' with either "mean" or "std"
* **meanstdonly**: selected from alldata only the columns that are in meanstdcols

***
#### Task 3: Uses descriptive activity names to name the activities in the data set
#### &
#### Task 4: Appropriately labels the data set with descriptive variable names.
  
Transformed data from Tasks 3 and 4:   

* 'meanstdonly' gets new labels from 'descriptivelabels'

Data frames from Tasks 3 and 4:

* **descriptivelabels**:  
        - only labels with espressions "mean" or "std" taken from 'features' thanks to 'meandstdcols'  
        - values as a vector to pass it later as labels for the 'describedactivities' dataset  
        - changed some short forms into more understandable terms
        
                - "mean" with "Mean"  
                - "std" with "StdDev " 
                - "f" with "Frequency-"  
                - "t" with "Time-"  
                - "Acc" with "-Accelerometer-"  
                - "Gyro" with "-Gyroscope-"  
                
***
* **describedactivities**: read the activity labels from 'activity_labels.txt' and merged  by left join() with alllabels data. Kept only "Mean" and "Std" Measurements

* **datasetfinal**: The complete data set. Mean and std only data frame merged with cbind() with all subjects and described activities.     

***  
#### Task 5: From the data set in step 4, creates a second, independent tidy data set
#### with the average of each variable for each activity and each subject.  

* New data frame **newdataset**: means of numeric columns of datasetfinal. Grouped by "Subject" and "Activity".  

***