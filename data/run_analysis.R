if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

#Unzipping the file
unzip(zipfile="./data/Dataset.zip",exdir="./data")

path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
files

#Reading the files
d_ActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
str(d_ActivityTest)

d_ActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
str(d_ActivityTest)

#subjectfiles
d_SubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
str(d_SubjectTrain)

d_SubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)
str(d_SubjectTest)


#Features files

d_FeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
str(d_FeaturesTest)

d_FeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)
str(d_FeaturesTrain)

#merging files to create one data set
dataSubject <- rbind(d_SubjectTrain, d_SubjectTest)
dataActivity<- rbind(d_ActivityTrain, d_ActivityTest)
dataFeatures<- rbind(d_FeaturesTrain, d_FeaturesTest)

#setting names to variables
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

#merging columns
combinedData <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, combinedData)

#subsetting the data
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)
str(Data)

#naming activities in the data set
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

#labeling datasets
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

#creating second dataset
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)

