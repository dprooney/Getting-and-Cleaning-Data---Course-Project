Getting-and-Cleaning-Data---Course-Project
==========================================

This repository pertains to the course project for JHU's *Getting and Cleaning Data* course. It contains:

* One R script: 'run_analysis.R'
* The code book detailing the variables: 'CodeBook.md'
* This readme file

The R script has 6 steps:

1. The raw data is extracted from the directory 'UCI HAR Dataset'. Note the raw data is not contained in this repository for space reasons. There are 6 sets: for the training data and the test data, there is a set of subject numbers (1-30), a set of activity numbers (1-6), and a set of measurements of 561 different variables.

2. We only care about the measurements that are means or standard deviations. In this step, the variable names (in 'features.txt') are read, and for any instance of '-mean()' or '-std()', the index is added to the vector 'm_and_sds'. This vector is then used to extract the 66 relevant variables out of the 561 original variables.

3. The variable names are then assigned to the data set. One could have used the names in the file 'features_info.txt' but it was decided these were very abbreviated. For cosmetically better names, all 66 new names were just typed out.

4. The activity names in the file 'activity_labels.txt' were deemed acceptable and so they are extracted from that file instead of typed out.

5. The data is then merged in two steps. For each of the training and test sets, a column bind is performed on the subject numbers, the activities, the measurements, and a factor variable distinguishing the training and test sets. Then a row bind is done on the test and training sets to create one large data set.

6. For each distinct subject/activity pair, the column means are calculated and row-bound together.





 
