---
title: "getdata-005 Class Project"
author: "sheldonwhite@comcast.net"
date: "July 19, 2014"
output: html_document
---

My implementation (https://github.com/sheldon-white/getdata-005-class-project/blob/master/run_analysis.R) is very simple:

1. It looks for an existing 'UCI HAR Dataset' directory. If not present, it downloads the zipfile and unpacks it.
2. It loades a vector containing the feature names from features.txt
3. It assembles data frames from the files in the 'test' and 'train' subdirectories:
    + It loads the 'X_' file containing the raw data.
    + It sets the column names from the feature names vector. Some minor cleanup is performed on the names, but complete clarity is impossible given the scanty documentation.
    + It removes all columns that aren't clearly a STD or MEAN value.
4. It binds the test and train datasets to a single frame
5. It converts the activity IDs to factor types, giving them the names corresponding to the mappings in the activities file.
6. It uses the aggregate() function to calculate mean values on each SubjectID/Activity combination.
6. It saves the resulting tidy dataset to 'tidydata.csv'

I found it quite challenging to interpret the data features in the UCI dataset. The following things seemed pretty clear:

* The 'X_' files contained the data measurements.
* The 'y_' files contained the activity IDs, since their range was 1 to 6.
* The 'subject_' files contained the subject IDs, since their range was 1 to 30.
* The 'features.txt' file contained the feature labels.
* It must be valid to combine all these tables with cbind() calls.

However, there are a lot of issues with the UCI data:

* There's very little documentation describing the __meaning__ of the labels (what does 'fBodyBodyGyroJerkMag-std()' represent?). I read the original paper (included here as https://github.com/sheldon-white/getdata-005-class-project/blob/master/SmartphoneBasedHumanActivityPrediction.pdf), but the descriptions of the data are pretty sketchy.
* There's no explicity description of the units these numbers represent. The measurements of linear acceleration __probably__ represent fractions of 1 G (9.87 M/Sec^2^) but that's not called out explicitly. I could not find any description of the Jerk or Gyro measurements.

In the end I did some rudimentary cleanups to the feature names, but mostly left them intact.
Also, there are other features like 'tBodyGyroJerkMean' and the '-meanFreq()' that are described as representing a mean value of some sort, but lacking a clear indication of how they were generated I decided to exclude them.