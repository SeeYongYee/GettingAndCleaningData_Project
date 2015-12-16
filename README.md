# Getting and Cleaning Data Course Project

*******
### This README.md file has 3 sections.
* Section 1 define the pre-requsite needed for the script to work properly.
* Section 2 describe the steps needed to run run_analysis.R script  
* Section 3 describe how the run_analysis.R script work. 

*******
## Section 1: Pre-requisite Requirements
* Additional R Package required: reshape2.
    + Can be installed using command: install.packages("reshape2")
* Obtained the data collected from the accelerometers from the Samsung Galaxy S smartphone
    + Download from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    + Unzip the data into your favourite folder.
    + In your favourite folder, a new folder "UCI HAR Dataset" will appear.
    + The "UCI HAR Dataset" folder contains all the data collected from the accelerometers.
* Obtained the run_analysis.R script
    + Download run_analysis.R script from gitHub
    + Save the run_analysis.R script into the same favourite folder as above

*******
## Section 2: Steps to run run_analysis.R script 
* Start up R Studio.
* Run the run_analysis.R script in R Studio.
    + In R Studio, change the current working directory to the favourite folder that contain both the run_analysis.R file and "UCI HAR Dataset" folder
    + In R Studio, input the command: source("run_analysis.R")
* Output produce by run_analysis.R script.
    + The run_analysis.R script will produce 1 output file "mean_measurement_by_subject_activity.txt".
    + This output file contain a tidy data set with the average of each variable for each activity and each subject.
    + It contains a total of 180 rows and 68 columns
    + 68 columns are make up of 1 subject variable + 1 activity variable + 66 measurement variables
    + 180 rows comprised of all combinations for 30 subjects and 6 activities

*******
## Section 3: Processing steps carried out by run_analysis.R 
#### The processing done by this script can be group into 8 major steps 
1. Reading from all relevant files into R
2. Merging the training and the test sets to create one data set
3. Extracting only the measurements on the mean and standard deviation for each measurement
4. Using descriptive activity names to name the activities in the data set
5. Labelling the data set with appropriate descriptive variable names
6. Creating the fully merged tidy data set with descriptive variable names
7. Creating a second, independent tidy data set with the average of each variable for each activity and each subject
8. Saving this dataset into file of name "mean_measurement_by_subject_activity.txt"
