Information about the variables (including units!) in the data set not contained in the tidy data
Information about the summary choices you made
Information about the experimental study design you used


## Original Data
The original data was retrieved from : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Data Set Information
Excerpt from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
>
>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Study Design
1. The raw data was downloaded and the following files unziped:
File|Description (from original ReadMe)
---|----
subject_train.txt|*Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.*
X_train.txt|*Training set*
y_train.txt|*Training labels*
subject_test.txt|*Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.*
x_test.txt|*Test set*
y_test.txt|*Test labels*
features.txt|*List of all features*
activity_labels.txt|*Links the class labels with their activity name*
