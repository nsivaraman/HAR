# HAR
Getting and Cleaning Data Project Human Activity Recognition on Smart Phones
Readme.md 
Created: 	9/26/2015
Author:		N Sivaraman


The script run_analysis.R prepares tidy data that can be used for later analysis. 
The data input for the script is data collected from the accelerometers from the Samsung Galaxy S smartphone.
Data can be obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

What does the script do:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

How to run
Unzip the data downloaded from url above to any folder
Start R (I wrote and tested in version 3.2.2, please try and use that version or higher)
Change working directory using the R command setwd() Ex. setwd("c:/class/r/proj")
If you have not installed dplyr package, the script will install it but you need to be connected to the internet.
Run script using source("run_analysis.R")
Note: for debugging purposes I have not removed any of the intermediate tables, if memory is an issue you can uncomment the rm() lines

Results of the script
After the script runs successfully it will create the output file UCI_HAR_Summary.txt in the working folder
You can view the results using the View command View(dfSumm)
You can read the file using read.table('UCI_HAR_Summary.txt',header=TRUE)"
You can view the details before the summary step using View(dfAll)

What are the files in the repo
1. This file README.md
2. The script file run_analysis.R
3. UCI_HAR_Summary.txt output from running the script file
4. CodeBook.txt describes the variables in the output file

