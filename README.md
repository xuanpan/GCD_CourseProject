# GCD Course Project

Getting and Cleaning Data Course Project

## Data Set Source

The data was collected from sensors of smartphone carried by experiment subject when performing certain activity. There have been 30 subjects, and each subject performed 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.

## Processes to Get Tidy Data

Code is written in R in file. Source file is run_analysis.R

The data.table package and dplyr package was required to run the R code in run_analysis.R file.

1. Download and unzip the data set file.

2. Read the relevant files to variables:
- features.txt -> featurenames
- activity_labels.txt -> activitylabels
- subject_train.txt -> subjecttrain
- y_train.txt -> activitytrain
- X_train.txt -> featuretrain
- subject_test.txt -> subjecttest
- y_test.txt -> activitytest
- X_test.txt -> featuretest

3. Merge the test and train data
- combine data in training and test data sets corresponding to subject, activity and features
- name variables
- merge columns to get the mergeddata

4. Extracts only the measurements on the mean and standard deviation for each measurement.

5. use descriptive activity names to name the activities in the data set

6. Appropriately labels the data set with descriptive variable names.

7. Creates an independent tidy dataset with the average (mean) of each variable for each activity and each subject.