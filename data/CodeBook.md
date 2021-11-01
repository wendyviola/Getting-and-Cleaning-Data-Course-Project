---
title: "CodeBook.md"
author: "me"
date: "10/31/2021"
output: html_document

The run_analysis.R script outlines how the raw data is prepared and the steps taken to clean it.
Step 1
download the given dataset and extract it which will then be stored under a folder called UCI HAR Dataset

Step 2
reading data from the files into the variable
Values of Varible Activity consist of data from “Y_train.txt” and “Y_test.txt”
values of Varible Subject consist of data from “subject_train.txt” and subject_test.txt"
Values of Varibles Features consist of data from “X_train.txt” and “X_test.txt”
Names of Varibles Features come from “features.txt”
levels of Varible Activity come from “activity_labels.txt”
Variable names are Activity, Features and Subject

Step 3
Merging the training and the test sets to create one data set. This is done by merging the rows and columns of the data sets
using the rbind() function and cbind() function

step 4
Extracts only the measurements on the mean and standard deviation for each measurement
Subset Name of Features by measurements on the mean and standard deviation
i.e taken Names of Features with “mean()” or “std()”
Subset the data frame Data by seleted names of Features

Step 5
Uses descriptive activity names to name the activities in the data set
Read descriptive activity names from “activity_labels.txt”

step 6
Appropriately labels the data set with descriptive variable names, Names of Feteatures will labelled using descriptive variable names
prefix t is replaced by time
Acc is replaced by Accelerometer
Gyro is replaced by Gyroscope
prefix f is replaced by frequency
Mag is replaced by Magnitude
BodyBody is replaced by Body

Step 7
Creating a second data set with the average of each variable for each activity and each subject
it is created by created by sumarizing Data taking the means of each variable for each activity and each subject, after being grouped by subject and activity  and named Data2
---

