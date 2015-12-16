#### =============================
#### Step 1: Reading from all relevant file into R
# =============================
# Reading in all training data
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
# dim output for all 3 data set show 7352 observations
# dim output for trainData show there are 561 measurement variables
# table output for trainLabel show there are 6 activities, with value 1 to 6
# table output for trainSubject show there are 21 volunteers ID, range from 1 to 30
# =============================
# Reading in all test data
testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
testLabel <- read.table("./UCI HAR Dataset/test/y_test.txt") 
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
# dim output for all 3 data set show 2947 observations
# dim output for testData show there are 561 measurement variables
# table output for testLabel show there are 6 activities, with value 1 to 6
# table output for testSubject show there are 9 volunteers ID, range from 1 to 30
# =============================
# Reading in features data
features <- read.table("./UCI HAR Dataset/features.txt")
# dim output show 561 observations with 2 variables
# features output show variable V1 is a sequence number from 1 to 561,
# while variable V2 is a description of measurement
# =============================
# Reading in activity_labels data
activityLabel <- read.table("./UCI HAR Dataset/activity_labels.txt")
# dim output show 6 observations with 2 variables
# activityLabel output show variable V1 is a sequence number from 1 to 6,
# while variable V2 is a description of activity conducted

#### =============================
#### Step 2: Merges the training and the test sets to create one data set
# =============================
# Merging data set for training and test
joinData <- rbind(trainData, testData)
joinLabel <- rbind(trainLabel, testLabel)
joinSubject <- rbind(trainSubject, testSubject)
# dim output for all 3 join data set show 10299 observations
# dim output for joinData show there are 561 measurement variables
# table output for joinLabel show there are 6 activities, with value 1 to 6
# table output for joinSubject show there are 30 volunteers ID, range from 1 to 30

#### =============================
#### Step 3: Extracts only the measurements on the mean and standard deviation for each measurement
# =============================
# Obtain the index from features data set for measurement on mean and standard deviation
indexMeanStd <- grep("mean\\(|std\\(", features[, 2])
# features[indexMeanStd,] output show mean and standard deviation are correctly capture
# length(indexMeanStd) output show there are 66 measurement in total
# =============================
# Extracts only the measurements on the mean and standard deviation for each measurement
joinData <- joinData[, indexMeanStd]
# dim(joinData) output show 10299 observations and 66 measurement variables

#### =============================
#### Step 4: Uses descriptive activity names to name the activities in the data set
# =============================
# Converting activity names with better description
activityLabel[,2] <- tolower(activityLabel[,2]) ## conversion to lower case letter
activityLabel[,2] <- gsub("_", "", activityLabel[,2]) ## removing _ character
# =============================
# Creating a listing of descriptive activity names corresponding to each 
# activity code (1 to 6) in joinLabel data set
joinActivityLabel <- activityLabel[joinLabel[,1],2]
# =============================
# Replace activity code with descriptive activity names
joinLabel[, 1] <- joinActivityLabel

#### =============================
#### Step 5: Appropriately labels the data set with descriptive variable names. 
# =============================
# Label the joinData with descriptive variable names
names(joinData) <- gsub("\\(\\)", "", features[indexMeanStd, 2]) # remove "()"
names(joinData) <- gsub("-", "", names(joinData)) # remove "-" in column names 
names(joinData) <- tolower(names(joinData)) # convert to lower case 
# =============================
# Label the joinLabel with descriptive variable names
names(joinLabel) <- "activity"
# =============================
# Label the joinSubject with descriptive variable names
names(joinSubject) <- "subject"

#### =============================
#### Step 6: Create the fully merged tidy data set with descriptive variable names
# =============================
# Create a single tidy data set
tidyData <- cbind(joinSubject, joinLabel, joinData)
# dim(tidyData) output show there are 10299 observations and 68 variables
# head(tidyData, 5) output show all columns are with descriptive variable names
# =============================
# Optional: Create a output file containing the cleaned merged dataset 
# write.table(tidyData, "cleaned_merged_data.txt")

#### =============================
#### Step 7: Creates a second, independent tidy data set with the average of each
#### variable for each activity and each subject. Save this dataset into file.
# =============================
#install.packages("reshape2")
library(reshape2)
# =============================
# Melt the tidyData set for each activity and subject
meltTidyData <- melt(tidyData, id=c("subject", "activity"))
# =============================
# Cast the meltTidyData set with average of each variable for each activity and subject
meanMeasurementBySubjectActivity <- dcast(meltTidyData, subject + activity ~ variable, mean)
# dim output show 180 observations and 68 variables
# 180 observations are expected. 30 subject * 6 activity
# 68 variables are expected. 1 subject variable + 1 activity variable + 66 measurement variables


#### =============================
#### Step 8: Save the newly created dataset into file of 
#### name "mean_measurement_by_subject_activity.txt"
# =============================
# Create a file "mean_measurement_by_subject_activity.txt" containing the new tidy dataset
write.table(meanMeasurementBySubjectActivity,"mean_measurement_by_subject_activity.txt", row.name=FALSE)
# =============================
