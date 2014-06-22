GettingCleaningData_Project1
============================

Coursera: Getting and Cleaning Data Project 1


The run_analysis.R script reads in all required data (subject, measurements, activity type) for both the training and test set. 
Variables are renamed descriptively; activity types are given labels ("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying").

The subject, measurement and activity datasets are then combined, for the training and test set respectively

Only columns that contain means or standard deviation data are extracted (meanFreq() is not included!)

The measurements are given more descriptive names.

Finally the dataset is converted to a long dataset, by subject and activity type.

A final dataset with the averages for each measurement variable by subject and activity type is created.


Load final dataset with:

data <- read.csv("Subj_Activity_avg.csv")
