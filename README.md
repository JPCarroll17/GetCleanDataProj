# GetCleanDataProj
Coursera Getting and Cleaning Data Final Project Submission

Before running any code, download and unzip the data from: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Read the documentation contained included with the data.  

Set up your working directory in R to the location of the unzipped data.

The run_analysis.R script will read in the test and training data as well as feature discriptions, activity labels and subject identifiers necessary to do the following:
  1. Merge the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names.
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each      subject.
