# Source of data for this project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# This R script does the following:

# 1. Merges the training and the test sets to create one data set.

A <- read.table("train/X_train.txt")
B <- read.table("test/X_test.txt")
X <- rbind(A, B)

A <- read.table("train/subject_train.txt")
B <- read.table("test/subject_test.txt")
S <- rbind(A, B)

A <- read.table("train/y_train.txt")
B <- read.table("test/y_test.txt")
Y <- rbind(A, B)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
good_data_indexes <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, good_data_indexes]
names(X) <- features[good_data_indexes, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. Uses descriptive activity names to name the activities in the data set.

Activity <- read.table("activity_labels.txt")
Activity[, 2] = gsub("_", "", tolower(as.character(Activity[, 2])))
Y[,1] = Activity[Y[,1], 2]
names(Y) <- "Activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(S) <- "Subject"
Cleansed <- cbind(S, Y, X)
write.table(Cleansed, "merged_cleansed_data.txt")

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(S)[,1]
CountSubjects = length(unique(S)[,1])
CountActivities = length(Activity[,1])
CountCols = dim(Cleansed)[2]
result = Cleansed[1:(CountSubjects*CountActivities), ]

row = 1
for (s in 1:CountSubjects) {
  for (a in 1:CountActivities) {
    result[row, 1] = uniqueSubjects[s]
    result[row, 2] = Activity[a, 2]
    tmp <- Cleansed[Cleansed$subject==s & Cleansed$activity==Activity[a, 2], ]
    result[row, 3:CountCols] <- colMeans(tmp[, 3:CountCols])
    row = row+1
  }
}
write.table(result, "tidy_ds_with_the_averages.txt")
