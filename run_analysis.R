################################################################################################
# Assignment: Getting and Cleaning Data Course Project
# 
# Description:
#   This script will use the UCI HAR Dataset to do the following :
#     + Download the data from : 
#       https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#     + Merge the training and the test set to create one data set.
#     + Extract only the measurements on the mean and standard deviation for each measurement.
#     + From resulting data, creates a second, independent tidy data set with the average of 
#       each variable for each activity and each subject.
#
#   The script will adhear to the following :
#     + Use descriptive activity names to name the activities in the data set
#     + Appropriately label the data set with descriptive variable names.
#
#   The result will include:
#     + subj_slim - a table with mean and std values for each measurement in Test and Train data
#     + subj_avg - a table with a tidy data set containing the average of each variable
# 
################################################################################################

# Clear workspace
rm(list = ls())

# Download data
dnTmp <- tempfile()
dnLoc <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dnLoc,dnTmp)
subj_train <- read.table(unz(dnTmp,"UCI HAR Dataset/train/subject_train.txt"))
subj_train_x <- read.table(unz(dnTmp,"UCI HAR Dataset/train/X_train.txt"))
subj_train_y <- read.table(unz(dnTmp,"UCI HAR Dataset/train/y_train.txt"))

subj_test <- read.table(unz(dnTmp,"UCI HAR Dataset/test/subject_test.txt"))
subj_test_x<- read.table(unz(dnTmp,"UCI HAR Dataset/test/X_test.txt"))
subj_test_y <- read.table(unz(dnTmp,"UCI HAR Dataset/test/y_test.txt"))

# Label columns
feature_cols <- read.table(unz(dnTmp,"UCI HAR Dataset/features.txt"))
colnames(feature_cols) = c("ID", "Label")
colnames(subj_train_x) <- feature_cols$Label
colnames(subj_test_x) <- feature_cols$Label

activ_cols <- read.table(unz(dnTmp,"UCI HAR Dataset/activity_labels.txt"))
colnames(activ_cols) = c("activID", "activLabel")
colnames(subj_train_y) = "activID"
colnames(subj_test_y) = "activID"

colnames(subj_train) = "subID"
colnames(subj_test) = "subID"

#combine tables for each data set
data_train = cbind(subj_train, subj_train_y, subj_train_x)
data_test = cbind(subj_test, subj_test_y, subj_test_x)

#Merge the training and the test set to create one data set.
data_merged <- rbind(data_train, data_test)

#Extract only the measurements on the mean and standard deviation for each measurement.
data_slim <-data_merged[c(c("subID","activID"),grep("(mean|std)\\(\\)",feature_cols$Label, value=TRUE))]

#make column names readable
#colnames(data_slim) = gsub("\\()","",colnames(data_slim))
colnames(data_slim) = gsub("-mean\\()","_Mean",colnames(data_slim))
colnames(data_slim) = gsub("-std\\()","_StdDev",colnames(data_slim))
colnames(data_slim) = gsub("^t","time_",colnames(data_slim))
colnames(data_slim) = gsub("^f","freq_",colnames(data_slim))
colnames(data_slim) = gsub("BodyBody","Body",colnames(data_slim))
colnames(data_slim) = gsub("Mag","Magnitude",colnames(data_slim))

#From resulting data, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#data_tidy <- data_slim[,names(data_slim) != c("activLabel")]
data_tidy <- aggregate(data_slim[,names(data_slim) != c("subID", "activID")],by=list(activID = data_slim$activID,subID = data_slim$subID), mean)

#label activities
data_slim = merge(activ_cols, data_slim)
data_tidy = merge(activ_cols, data_tidy)

#get save loc
print("Select save location using file dialog...")
outLoc <- choose.dir(default = "", caption = "Select a location for the output")
if(file.exists(outLoc)) {
  setwd(outLoc)
  write.table(data_tidy, "tidy.csv", sep = ",", row.names = FALSE)
  print(paste("Tidy data saved to: ",outLoc,"\tidy.csv",sep=""))
}else {
  print("Save location missing, file not saved.")}

# Remove temp file
unlink(dnTmp, recursive=TRUE)
