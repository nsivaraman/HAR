## run_analysis.R
## Getting and cleaning data course
## This script does the following 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Each data set test and training is in 3 files
## first let us combine the subject_.txt, X_.txt and Y_.txt of test and training
## Note I'm always using test first
## function to check if a package is installed
is.installed <- function(mypkg) is.element(mypkg, installed.packages()[,1]) ## Ex. is.installed("dplyr")
## check if dplyr is installed and install if not
if (!is.installed("dplyr")) install.packages("dplyr")
## Load library dplyr
library(dplyr)
# Change to data folder
setwd("c:/class/r/proj")

## Start objective 1. Merges the training and the test sets to create one data set.
#Load test X file into a data frame
dfTest<-read.table("test/X_test.txt")

## test df with dim(dfTest), str(dfTest) ...

#Load training X file into a data frame
dfTrain<-read.table("train/X_train.txt")

## combine rows of test and training
dfTestTrain<-bind_rows(dfTest,dfTrain)

## Set variable/column names for the data frame
## variable name are in features.txt file
## read the features file
feat<-read.table("features.txt",stringsAsFactors=FALSE)
## variable names are in the 2nd column
names(dfTestTrain)=make.names(feat[,2],unique=TRUE)

## Load and combine subject_ files similar to above
dfTestSubjects<-read.table("test/subject_test.txt")
dfTrainSubjects<-read.table("train/subject_train.txt")
dfTestTrainSubjects<-bind_rows(dfTestSubjects,dfTrainSubjects)
## set column name
names(dfTestTrainSubjects)[1]="Subject"

## Load and combine Y_ files
dfTestActivity<-read.table("test/y_test.txt")
dfTrainActivity<-read.table("train/y_train.txt")
dfTestTrainActivity<-bind_rows(dfTestActivity,dfTrainActivity)
names(dfTestTrainActivity)[1]="Activity"

## End objective 1. Merges the training and the test sets to create one data set.

## Start objective 2. Extracts only the measurements on the mean and standard deviation for each measurement.

## We are selecting only columns that are mean() or std() during the make.names step these columns were converted to mean... and std...
dfTestTrain<-select(dfTestTrain,matches(".mean..|.std.."))

## End objective 2. Extracts only the measurements on the mean and standard deviation for each measurement.

## Start objective 3. Uses descriptive activity names to name the activities in the data set

## This function will return an activity name given a activity #
## There must be a better way to do this than ifelse i'm thinking switch but for now this works
activityName<-function(activityNum) ifelse(activityNum==1,"WALKING",ifelse(activityNum==2,"WALKING_UPSTAIRS",ifelse(activityNum==3,"WALKING_DOWNSTAIRS",ifelse(activityNum==4,"SITTING",ifelse(activityNum==5,"STANDING","LAYING")))))

dfTestTrainActivity<-mutate(dfTestTrainActivity,Activity=activityName(Activity))

## End objective 3. Uses descriptive activity names to name the activities in the data set

## Start objective 4. Appropriately labels the data set with descriptive variable names. 
## I did this as part of Objective 2 by assigning the variables names from the features.txt, this allowed me to just select the variables
##   with mean(), std()
## End objective 4. Appropriately labels the data set with descriptive variable names. 

## Start objective 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
##   for each activity and each subject.

## let's combine the 3 data frames
dfAll<-bind_cols(dfTestTrainSubjects,dfTestTrainActivity,dfTestTrain)

## group by subject and activity
dfGrouped<-group_by(dfAll,Activity,Subject)
## summarize with mean on rest of the columns
dfSumm<-summarize_each(dfGrouped, funs(mean))

## End objective 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
##   for each activity and each subject.

## Now write the table out
write.table(dfSumm,"UCI_HAR_Summary.txt",row.names=FALSE)

print("Summary exported as UCI_HAR_Summary.txt")
print("Use read.table('UCI_HAR_Summary.txt',header=TRUE)")

## End of Program
