Introduction

The script run_analysis.R executes the 5 steps described in the course project's definition below

1) First, all the similar data is merged using the rbind() function. By similar, we address those files having the same number of columns and referring to the same entities.
2) Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from features.txt.
3) As activity data is addressed with values 1:6, we take the activity names and IDs from activity_labels.txt and they are substituted in the dataset.
4) On the whole dataset, those columns with vague column names are corrected.
5) Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called averages_data.txt, and uploaded to this repository.

Variables

For 1)
A and B are temporary variables which are used to load train and test attributes respectively.
First we load X_train and X_test into A and B and rbind A and B to generate variable X.
Next we load Subject_train and Subject_test into A and B and rbind A and B to generate variable S.
Lastly we load Y_train and Y_test into A and B and rbind A and B to generate variable Y.

For 2)
features.txt is loaded in features variable.
indices of good data having mean and standard deviation are extracted into good_data_indexes variable.

X variable is overwriten with the data from these indices.

For 3)

Activity variable is created by loading data from activity_labels.txt file.

At the end of this step we have descriptive activity names appended to the dataset.

For 4)

Cleansed variable is created by cbinding  Subject (S), Y and X respectively. data is extracted into merged_cleansed_data.txt file.

For 5)

uniqueSubjects variable is created to store unique subjects values.
CountSubjects variable is created to store the count of unique subjects.
CountActivities variable stores the unique activity Counts.
CountCols has count of number of columns.
result variable has cleased data for the first row.

For loop would generate the desired data set and save in the file tidy_ds_with_the_averages.txt
