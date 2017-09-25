library(data.table)
library(dplyr)

# get file
if(!file.exists("./getdata_projectfiles_UCI HAR Dataset.zip")){
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(url, "./getdata_projectfiles_UCI HAR Dataset.zip", method = "curl")
        unzip("./getdata_projectfiles_UCI HAR Dataset.zip")
}

# Read metadata
featurenames <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE, stringsAsFactors = FALSE)

# Read training data
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activitytrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
featurestrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

# Read test data
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activitytest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuretest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

# combine data in training and test data sets corresponding to subject, activity and features
subject <- rbind(subjecttrain, subjecttest)
activity <- rbind(activitytrain, activitytest)
features <- rbind(featurestrain, featuretest)

# Name variables
colnames(features) <- featurenames[,2]
colnames(activity) <- "activity"
colnames(subject) <- "subject"

# Merge data
mergeddata <- cbind(subject, activity, features)

# extract the measurement on mean and std
mergeddatameanstd <- mergeddata[, c(1, 2, grep(".*mean.*|.*std.*", names(mergeddata)))] 

# use descriptive activity names to name the activities in the data set
mergeddatameanstd$activity <- as.character(mergeddatameanstd$activity)
for (i in 1:nrow(mergeddatameanstd)) {
        mergeddatameanstd[i, 2] <- activitylabels[mergeddatameanstd[i, 2], 2]
}

# Appropriately labels the data set with descriptive variable names
names(mergeddatameanstd)
names(mergeddatameanstd) <- gsub("^t", "time", names(mergeddatameanstd))
names(mergeddatameanstd) <- gsub("^f", "frequency", names(mergeddatameanstd))
names(mergeddatameanstd) <- gsub("Acc", "Accelerometer", names(mergeddatameanstd))
names(mergeddatameanstd) <- gsub("Gyro", "Gyroscope", names(mergeddatameanstd))
names(mergeddatameanstd) <- gsub("Mag", "Magnitude", names(mergeddatameanstd))
names(mergeddatameanstd) <- gsub("BodyBody", "Body", names(mergeddatameanstd))
names(mergeddatameanstd)

# Create an independent tidy data set
tidydata <- aggregate(. ~subject + activity, mergeddatameanstd, mean)
tidydata <- arrange(tidydata, subject, activity)
write.table(tidydata,file = "tidydata.txt", row.name=FALSE)

