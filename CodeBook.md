# Getting and Cleaning Data Course Project

*******
### This CodeBook.md file has 4 sections
* Section 1 describe the data source
* Section 2 describe the processed data 
* Section 3 describe the transformation process from data source to the processed data
* Section 4 describe the columns (or variables) in the processed data

*******
## Section 1: Input Data Source
* The full description of the data collected from the accelerometers from the Samsung Galaxy S smartphone, is available in http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
* The data source used for the project is downloaded from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

*******
## Section 2: Processed Data Output
* The run_analysis.R script will read in data from input source (refer to Section 1), processed it and generate a output file of name "mean_measurement_by_subject_activity.txt" 
* This output file contain a tidy data set with the average of each variable for each activity and each subject.
    + It contains a total of 180 rows and 68 columns
    + 68 columns are make up of 1 subject variable + 1 activity variable + 66 measurement variables (refer to Section 4 for detail)
    + 180 rows comprised of all combinations for 30 subjects and 6 activities

*******
## Section 3: Transformation process from input data source to the processed data output
* This section describe the transformation done by run_analysis.R script.
* For steps related to running the run_analysis.R script, kindly refer to the README.md
* The processing done by this script can be group into 8 major steps 
    1. Reading from all relevant files into R
        + Read X_train.txt, y_train.txt and subject_train.txt from the "./UCI HAR Dataset/train" folder and store them in trainData, trainLabel and trainSubject variables respectively
        + Read X_test.txt, y_test.txt and subject_test.txt from the "./UCI HAR Dataset/test" folder and store them in testData, testLabel and testsubject variables respectively
        + Read features.txt from the "./UCI HAR Dataset" folder and store it in features variables
        + Read activity_labels.txt from the "./UCI HAR Dataset" folder and store it in activityLabel variables
    2. Merging the training and the test sets to create one data set
        + Concatenate testData and trainData to generate joinData variable, having dimension 10299x561
        + Concatenate testLabel and trainLabel to generate joinLabel variable, having dimension 10299x1 
        + Concatenate testSubject and trainSubject to generate joinSubject variable, having dimension 10299x1
    3. Extracting only the measurements on the mean and standard deviation for each measurement
        + Use the grep function on features variable to generate indexMeanStd variable, which is an index listing for the measurement on mean and standard deviation
        + Extract only the measurements on mean and standard deviation using indexMeanStd variable on joinData variable, and save the filtered data back into joinData variable
        + The joinData variable will now have 66 columns instead of 561
    4. Using descriptive activity names to name the activities in the data set
        + Use the tolower function to convert activityLabel into lower cases
        + Use the gsub function to remove _ character from activityLabel
        + Use joinLabel variable on activityLabel variable to generate a corresponding descriptive activity names from activity code (1 to 6)
        + Replace activity code with descriptive activity names in joinLabel variable
    5. Labelling the data set with appropriate descriptive variable names
        + Use the gsub function to remove () from featues variable and assign the output to the column name for joinData variable using names function
        + Use the gsub function to remove - from the column name of joinData variable, and assign it back to the column name for joinData variable using names function
        + Use the tolower function to lower case the column name of joinData variable, and assign it back to the column name for joinData variable using names function
        + Use the names function to assign "activity" as the column name for joinLabel variable
        + Use the names function to assign "subject" as the column name for joinSubject variable
    6. Creating the fully merged tidy data set with descriptive variable names
        + Use the cbind function on joinSubject, joinLabel and joinData variable to generate tidyData variable, which contains the fully merged tidy data set with descriptive variable names
        + The tidyData variable has a dimension of 10299X68 (ie. 10299 observations and 68 variables)
        + The first column of tidyData has a column name "subject", having only value 1 to 30
        + The second column of tidyData has a column name "activity", having only 6 types of activity
    7. Creating a second, independent tidy data set with the average of each variable for each activity and each subject
        + Use the library function to load the reshape2 package
        + Use the melt function to breakdown the tidyData variable by subject and activity for each measurement, and save the output into meltTidyData variable
        + Use the dcast function on meltTidyData variable and applying mean function, to generate the mean of each measurement by subject and activity, into meanMeasurementBySubjectActivity variable
        + The meanMeasurementBySubjectActivity variable has a dimension of 180X68
    8. Saving this dataset into file of name "mean_measurement_by_subject_activity.txt"
        + Use the write.table function on meanMeasurementBySubjectActivity variable, to generate the output file "mean_measurement_by_subject_activity.txt"

*******
## Section 4: Columns (or variables) in the processed data output
* The processed data output file "mean_measurement_by_subject_activity.txt" has a total of 180 rows by 68 columns
* The 68 columns are:
    1. "subject" contains only value from 1 to 30, each representing a participant in the study
    2. "activity" contains only 6 descriptive activity names (ie. walking, walkingupstairs, walkingdownstairs, sitting, standing and laying)
    3. "tbodyaccmeanx"
    4. "tbodyaccmeany"
    5. "tbodyaccmeanz"
    6. "tbodyaccstdx"
    7. "tbodyaccstdy"
    8. "tbodyaccstdz"
    9. "tgravityaccmeanx"
    10. "tgravityaccmeany"
    11. "tgravityaccmeanz"
    12. "tgravityaccstdx"
    13. "tgravityaccstdy"
    14. "tgravityaccstdz"
    15. "tbodyaccjerkmeanx"
    16. "tbodyaccjerkmeany"
    17. "tbodyaccjerkmeanz"
    18. "tbodyaccjerkstdx"
    19. "tbodyaccjerkstdy"
    20. "tbodyaccjerkstdz"
    21. "tbodygyromeanx"
    22. "tbodygyromeany"
    23. "tbodygyromeanz"
    24. "tbodygyrostdx"
    25. "tbodygyrostdy"
    26. "tbodygyrostdz"
    27. "tbodygyrojerkmeanx"
    28. "tbodygyrojerkmeany"
    29. "tbodygyrojerkmeanz"
    30. "tbodygyrojerkstdx" 
    31. "tbodygyrojerkstdy" 
    32. "tbodygyrojerkstdz" 
    33. "tbodyaccmagmean" 
    34. "tbodyaccmagstd" 
    35. "tgravityaccmagmean" 
    36. "tgravityaccmagstd" 
    37. "tbodyaccjerkmagmean" 
    38. "tbodyaccjerkmagstd" 
    39. "tbodygyromagmean" 
    40. "tbodygyromagstd" 
    41. "tbodygyrojerkmagmean" 
    42. "tbodygyrojerkmagstd" 
    43. "fbodyaccmeanx" 
    44. "fbodyaccmeany" 
    45. "fbodyaccmeanz" 
    46. "fbodyaccstdx" 
    47. "fbodyaccstdy" 
    48. "fbodyaccstdz" 
    49. "fbodyaccjerkmeanx" 
    50. "fbodyaccjerkmeany" 
    51. "fbodyaccjerkmeanz" 
    52. "fbodyaccjerkstdx" 
    53. "fbodyaccjerkstdy" 
    54. "fbodyaccjerkstdz" 
    55. "fbodygyromeanx" 
    56. "fbodygyromeany" 
    57. "fbodygyromeanz" 
    58. "fbodygyrostdx" 
    59. "fbodygyrostdy" 
    60. "fbodygyrostdz" 
    61. "fbodyaccmagmean" 
    62. "fbodyaccmagstd" 
    63. "fbodybodyaccjerkmagmean" 
    64. "fbodybodyaccjerkmagstd" 
    65. "fbodybodygyromagmean" 
    66. "fbodybodygyromagstd" 
    67. "fbodybodygyrojerkmagmean" 
    68. "fbodybodygyrojerkmagstd"
