# getdata-005-class-project

My implentation (https://github.com/sheldon-white/getdata-005-class-project/blob/master/run_analysis.R) is very simple:
* It looks for an existing 'UCI HAR Dataset' directory. If not present, it downloads the zipfile and unpacks it.
* It loades the feature names from features.txt
* It assembles data frames from the files in the 'test' and 'train' subdirectories.
* It binds the test and train datasets to a single frame
* It converts the activity IDs to factor types, gining them descriptive names.
* It saves the resulting tidy dataset to 'tidydata.csv'

I found it quite challenging to interpret the data features in the UCI dataset. The following things seemed pretty clear:
* The 'X_' files contained the data measurements.
* The 'y_' files contained the activity IDs, since their range was 1 to 6.
* The 'subject_' files contained the subject IDs, since their range was 1 to 30.
* The 'features.txt' file contained the feature labels.

However, there are a lot of issues with the UCI data:


