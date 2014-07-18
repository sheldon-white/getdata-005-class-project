#!/usr/bin/Rscript

# Where all datafiles live
dataDir = "UCI HAR Dataset"
UCIDatasetURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#
# Assemble all data from a UCI experimental phase.
#' Load, prune and assemble the files from one of the test or stage directories in the UCI data directory.
#' In either subdirectory:
#' 1) the X_<dirname>.txt file contains all the experimental observations (features), one row per experiment.
#' 2) The y_<dirname>.txt file contains the activity IDs, one row per experiment.
#' 3) The subject_<dirname>.txt file contains all the subject IDs, one row per experiment.
#' We load the observations into a frame, assign the featureNames loaded from the top-level features.txt file,
#' remove all columns that don't match "std()" or "mean() or "angle(...)". Then we load the subject IDS and activity IDs and
#' bind them to the left side of the large resulting frame. We should end up with 68 columns.
#' @param featureNames A vector containing all observational types in the experiment.
#' @param phase The experimental phase: "test" or "train"
#' @return A frame containing the pruned and assembled data.
#
assembleDataFromDirectory <- function(featureNames, phase) {
	subdir = paste(dataDir, "/", phase, sep="")
	if (!file.exists(subdir)) {
		stop("Directory ", subdir, " doesn't exist; aborting...") 
	}
	
	# 'X_' file contains all feature values, one row per experiment
	featureValuesFile = paste(subdir, "/X_", phase, ".txt", sep="")
	message("file = ", featureValuesFile)
	if (!file.exists(subdir)) {
		stop("Required file ", featureValuesFile, " doesn't exist; aborting...") 
	}
	# load all the values
	featureValues = read.table(featureValuesFile)
	# set the column names
	colnames(featureValues) = featureNames
	# Eliminate all columns that don't represent a mean or standard deviation.
	featureValues = featureValues[,grep("-std(-[A-Z])?$|-mean(-[A-Z])?$", colnames(featureValues), value=TRUE, fixed=FALSE)]
	
    # Weld on the subject IDs and activities
	subjectFrame = loadSubjectFile(phase)
	activityFrame = loadActivityFile(phase)
	dataFrame = cbind(subjectFrame, activityFrame, featureValues)
	dataFrame
}

#
# Return a vector returning all the names in the features.txt file
#
loadSubjectFile <- function(phase) {
	subdir = paste(dataDir, "/", phase, sep="")
	subjectFile = paste(subdir, "/subject_", phase, ".txt", sep="")
	if (!file.exists(subjectFile)) {
		stop("Subject file ", subjectFile, " doesn't exist; aborting...") 
	}
	message("Loading subject ids from ", subjectFile)
	subjectFrame = read.table(subjectFile)
	colnames(subjectFrame) = c("SubjectID")
	subjectFrame
}

#
# Return a vector returning all the activities in y_<phase>.txt file
#
loadActivityFile <- function(phase) {
	subdir = paste(dataDir, "/", phase, sep="")
	activityFile = paste(subdir, "/y_", phase, ".txt", sep="")
	if (!file.exists(activityFile)) {
		stop("Activity file ", activityFile, " doesn't exist; aborting...") 
	}
	message("Loading activity ids from ", activityFile)
	activityFrame = read.table(activityFile)
	colnames(activityFrame) = c("Activity")
	
	activityFrame
}

#
# Return a vector returning all the names in the features.txt file
#
loadFeatureNames <- function() {
	featuresFile = paste(dataDir, "/", "features.txt", sep="")
	if (!file.exists(featuresFile)) {
		stop("Features file ", featuresFile, " doesn't exist; aborting...") 
	}
	message("Loading feature names from ", featuresFile)
	featureFrame = read.table(featuresFile)
	featureNames = featureFrame[,2]
    
    # Try to clarify some of the feature names, but the original names are really
    # a mess ("BodyBody"?) and the original paper does a poor job of describing the data that was collected.
    # So this is probably fruitless...
	featureNames = sub("^tBody", "TimeBody", featureNames)
	featureNames = sub("^fBody", "FFTBody", featureNames)
	featureNames = sub("^tGravity", "TimeGravity", featureNames)
	featureNames = sub("Acc", "Acceleration", featureNames)
	featureNames = sub("Mag", "Magnitude", featureNames)
    # pull off the parentheses
	featureNames = sub("\\(\\)", "", featureNames)
	
	featureNames
}




##########################################################################################
# Main program
##########################################################################################

# Retrieve and unzip the zipfile from configured URL
if (!file.exists(dataDir)){
	zipFile = "UCIDataset.zip"
	message("Retrieving ", UCIDatasetURL)
	f <- tempfile() 
	download.file(UCIDatasetURL, f, method="curl") 
	unzip(f)
}

# Load feature names
featureNames = loadFeatureNames()

# Build the test data frame
testFullData = assembleDataFromDirectory(featureNames, "test")
 
# Build the train data frame
trainFullData = assembleDataFromDirectory(featureNames, "train")

# Weld the two frames together, test first
fullData = rbind(testFullData, trainFullData)

# Convert activity IDs to feature types
fullData$Activity = factor(fullData$Activity)
fullData$Activity = revalue(fullData$Activity, c("1" = "Walking", "2" = "WalkingUpstairs", "3" = "WalkingDownstairs", "4" = "Sitting", "5" = "Standing", "6" = "Laying"))

# Create a new frame that contains the average of all numeric columns for each subject/activity pair
# Then save the aggregated data to disk
tidy = aggregate(fullData[3:68], by=fullData[c("Activity", "SubjectID")], FUN=mean)
write.csv(tidy,"tidydata.csv")
