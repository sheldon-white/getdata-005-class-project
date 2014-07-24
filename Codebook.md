---
title: "Codebook for 'Getting and Cleaning Data' Class Project"
author: "sheldonwhite@comcast.net"
date: "July 19, 2014"
output: html_document
---

The data described here was prepared as part of the "Getting and Cleaning Data" course. (https://class.coursera.org/getdata-005). It represents a cleaned subset of a large dataset produced by the UCI Center for Machine Learning and Intelligent Systems. A copy of the original dataset can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Data Transformations
--------------------
The following steps were performed to create the final dataset:

1. Data was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. File was unzipped to the data directory "UCI HAR Dataset".
3. The file "UCI HAR Dataset/features.txt" was loaded to get a list of feature names. Some minor cleanups to the featurenames were performed:
  + Names beginning with 'tBody' now begin with 'TimeBody'
  + Names beginning with 'fBody' now begin with 'FFTBody'
  + Names beginning with 'tGravity' now begin with 'TimeGravity'
  + 'Acc' was expanded to 'Acceleration'
  + 'Mag' was expanded to 'Magnitude'
  + The '()' substrings were removed from all names
  
4. The data is divided into two subsets, contained in the "UCI HAR Dataset/test" and the "UCI HAR Dataset/train" subdirectores. For each subset the following operations were performed:
  + The file "<subset>/X_<subset>.txt" was loaded to create a dataframe containing the measurements, one row per experiment.
  + The file "<subset>/subject_<subset>.txt" was loaded and added as a 'SubjectID' column.
  + The file "<subset>/y_<subset>.txt" was loaded and added as an 'Activity' column.
  + All columns not explicitly a mean or standard-deviation value (not ending in '-std', '-mean', with or without an axis identifier like '-X') were removed.
5. The activity IDs were converted to descriptive names base on the contents of "UCI HAR Dataset/activity_labels.txt'
6. Finally, all numeric columns were aggregated to mean values, aggregated on each SubjectId/Activity combunation.


Variable Names
--------------

Overview of Data
----------------

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

> These signals were used to estimate variables of the feature vector for each pattern:  
> '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

All numeric measurements are dimensionless, normalized and bounded in the range [-1, +1].

Variables
---------




Activity
SubjectID
TimeBodyAcceleration-mean-X
TimeBodyAcceleration-mean-Y
TimeBodyAcceleration-mean-Z
TimeBodyAcceleration-std-X
TimeBodyAcceleration-std-Y
TimeBodyAcceleration-std-Z
TimeGravityAcceleration-mean-X
TimeGravityAcceleration-mean-Y
TimeGravityAcceleration-mean-Z
TimeGravityAcceleration-std-X
TimeGravityAcceleration-std-Y
TimeGravityAcceleration-std-Z
TimeBodyAccelerationJerk-mean-X
TimeBodyAccelerationJerk-mean-Y
TimeBodyAccelerationJerk-mean-Z
TimeBodyAccelerationJerk-std-X
TimeBodyAccelerationJerk-std-Y
TimeBodyAccelerationJerk-std-Z
TimeBodyGyro-mean-X
TimeBodyGyro-mean-Y
TimeBodyGyro-mean-Z
TimeBodyGyro-std-X
TimeBodyGyro-std-Y
TimeBodyGyro-std-Z
TimeBodyGyroJerk-mean-X
TimeBodyGyroJerk-mean-Y
TimeBodyGyroJerk-mean-Z
TimeBodyGyroJerk-std-X
TimeBodyGyroJerk-std-Y
TimeBodyGyroJerk-std-Z
TimeBodyAccelerationMagnitude-mean
TimeBodyAccelerationMagnitude-std
TimeGravityAccelerationMagnitude-mean
TimeGravityAccelerationMagnitude-std
TimeBodyAccelerationJerkMagnitude-mean
TimeBodyAccelerationJerkMagnitude-std
TimeBodyGyroMagnitude-mean
TimeBodyGyroMagnitude-std
TimeBodyGyroJerkMagnitude-mean
TimeBodyGyroJerkMagnitude-std
FFTBodyAcceleration-mean-X
FFTBodyAcceleration-mean-Y
FFTBodyAcceleration-mean-Z
FFTBodyAcceleration-std-X
FFTBodyAcceleration-std-Y
FFTBodyAcceleration-std-Z
FFTBodyAccelerationJerk-mean-X
FFTBodyAccelerationJerk-mean-Y
FFTBodyAccelerationJerk-mean-Z
FFTBodyAccelerationJerk-std-X
FFTBodyAccelerationJerk-std-Y
FFTBodyAccelerationJerk-std-Z
FFTBodyGyro-mean-X
FFTBodyGyro-mean-Y
FFTBodyGyro-mean-Z
FFTBodyGyro-std-X
FFTBodyGyro-std-Y
FFTBodyGyro-std-Z
FFTBodyAccelerationMagnitude-mean
FFTBodyAccelerationMagnitude-std
FFTBodyBodyAccelerationJerkMagnitude-mean
FFTBodyBodyAccelerationJerkMagnitude-std
FFTBodyBodyGyroMagnitude-mean
FFTBodyBodyGyroMagnitude-std
FFTBodyBodyGyroJerkMagnitude-mean
FFTBodyBodyGyroJerkMagnitude-std