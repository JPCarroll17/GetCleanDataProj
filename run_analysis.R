##JCarroll
##Assignment Coursera Getting and Cleaning Data
##Read in, merge, clean and aggregate data from multiple users of activity monitors.
##5/28/2017
##Set working directory to location of data downloaded from:
##https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
setwd("/Users/JPCarroll/Desktop/Coursera/Data_Science_Coursera/GetCleanData/Project/Data")


#import necessary libraries
library(plyr)
library(stringr)

#Read in data labels
Features=read.table("./UCI HAR Dataset/features.txt", col.names = c("Feat_Num","Feature" ))
Act_Labels=read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("Activity","Activity_Label" ))

#read in testing data
XTest=read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
YTest=read.table("./UCI HAR Dataset/test/Y_test.txt", col.names = "Activity");
SubTest=read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = "Subject");

#read in training data
XTrain=read.table("./UCI HAR Dataset/Train/X_Train.txt", header = FALSE)
YTrain=read.table("./UCI HAR Dataset/Train/Y_Train.txt", header = FALSE, col.names = "Activity");
SubTrain=read.table("./UCI HAR Dataset/Train/subject_Train.txt", header = FALSE, col.names = "Subject");


#Combine Training and Testing data
XALL<-rbind(XTest,XTrain)
YALL<-rbind(YTest,YTrain)
SubALL<-rbind(SubTest,SubTrain)
Combined_ALL<-cbind(SubALL,YALL,XALL)

#Remove datasets that are no longer needed
rm(XTest,YTest,XTrain,YTrain,SubTest,SubTrain,SubALL,YALL,XALL)

#Update column and row names
names(Combined_ALL)[3:length(Combined_ALL)[1]]<-t(Features[2])
row.names(Combined_ALL)<-1:dim(Combined_ALL)[1]

#Apply activity labels to data
Combined_ALL$Activity<-factor(Combined_ALL$Activity,levels=Act_Labels$Activity, labels=Act_Labels$Activity_Label)


#Keep only mean and Standard Deviation records
Final<-Combined_ALL[grepl("Subject|Activity|[mM]ean\\(\\)|[sS]td\\(\\)",names(Combined_ALL))]#includes only mean and std records

#Remove datasets that are no longer needed
rm(Act_Labels, Features, Combined_ALL)

#Give appropriate names to variables
names(Final) <- gsub('^t',"Time_",names(Final))
names(Final) <- gsub('^f',"Frequency_",names(Final))
names(Final) <- gsub('-',"_",names(Final))
names(Final) <- gsub('\\(\\)',"",names(Final))

#Aggregate data by Subject and Activity using mean
Tidy_data<-aggregate(. ~Subject + Activity, Final, mean)

#write out aggregated data to working directory
write.table(Tidy_data, file = "Tidy.txt", append = FALSE, quote = TRUE, sep = " ",row.names = FALSE)

