
# load required libraries
require(reshape2)

# Read in Data
features <- read.table("UCI HAR Dataset/features.txt", header=F, stringsAsFactors=F)
subTest <- read.table(file = "UCI HAR Dataset/test/subject_test.txt", header = F)
xtest <- read.table(file = "UCI HAR Dataset/test/X_test.txt", header=F)
ytest <- read.table(file = "UCI HAR Dataset/test/y_test.txt", header = F)

subtrain <- read.table(file = "UCI HAR Dataset/train/subject_train.txt", header = F)
xtrain <- read.table(file = "UCI HAR Dataset/train/X_train.txt", header=F)
ytrain <- read.table(file = "UCI HAR Dataset/train/y_train.txt", header = F)

# rename columns
names(subTest)<- "Subject"
names(xtest) <- features$V2
names(ytest) <- "Activity"

names(subtrain)<- "Subject"
names(xtrain) <- features$V2
names(ytrain) <- "Activity"

# Add activity labels
ytrain$Activity <- factor(ytrain$Activity, labels = c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))
ytest$Activity  <- factor(ytest$Activity, labels = c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))


# Combine
testData <- cbind(subTest, xtest, ytest)
trainData <- cbind(subtrain, xtrain, ytrain)
completeData <- rbind(trainData, testData)

# index columns to summarize
dataCols <- grep("mean\\(|std", names(completeData))

# reduce dataset (subj, mean/std cols, activity)
limitedSet <- completeData[, c(1,dataCols, 563)]

# rename more descriptively
names(limitedSet) <- names(limitedSet) <- c("Subject",
                                            "Time_Body_Acceleration-mean()-X",
                                            "Time_Body_Acceleration-mean()-Y",
                                            "Time_Body_Acceleration-mean()-Z",
                                            "Time_Body_Acceleration-std()-X",
                                            "Time_Body_Acceleration-std()-Y",
                                            "Time_Body_Acceleration-std()-Z",
                                            "Time_Gravity_Acceleration-mean()-X",
                                            "Time_Gravity_Acceleration-mean()-Y",
                                            "Time_Gravity_Acceleration-mean()-Z",
                                            "Time_Gravity_Acceleration-std()-X",
                                            "Time_Gravity_Acceleration-std()-Y",
                                            "Time_Gravity_Acceleration-std()-Z",
                                            "Time_Body_Acceleration_Jerk-mean()-X",
                                            "Time_Body_Acceleration_Jerk-mean()-Y",
                                            "Time_Body_Acceleration_Jerk-mean()-Z",
                                            "Time_Body_Acceleration_Jerk-std()-X",
                                            "Time_Body_Acceleration_Jerk-std()-Y",
                                            "Time_Body_Acceleration_Jerk-std()-Z",
                                            "Time_Body_Gyro-mean()-X",
                                            "Time_Body_Gyro-mean()-Y",
                                            "Time_Body_Gyro-mean()-Z",
                                            "Time_Body_Gyro-std()-X",
                                            "Time_Body_Gyro-std()-Y",
                                            "Time_Body_Gyro-std()-Z",
                                            "Time_Body_Gyro_Jerk-mean()-X",
                                            "Time_Body_Gyro_Jerk-mean()-Y",
                                            "Time_Body_Gyro_Jerk-mean()-Z",
                                            "Time_Body_Gyro_Jerk-std()-X",
                                            "Time_Body_Gyro_Jerk-std()-Y",
                                            "Time_Body_Gyro_Jerk-std()-Z",
                                            "Time_Body_Acceleration_Magnitude-mean()",
                                            "Time_Body_Acceleration_Magnitude-std()",
                                            "Time_Gravity_Acceleration_Magnitude-mean()",
                                            "Time_Gravity_Acceleration_Magnitude-std()",
                                            "Time_Body_Acceleration_Jerk_Magnitude-mean()",
                                            "Time_Body_Acceleration_Jerk_Magnitude-std()",
                                            "Time_Body_Gyro_Magnitude-mean()",
                                            "Time_Body_Gyro_Magnitude-std()",
                                            "Time_Body_Gyro_Jerk_Magnitude-mean()",
                                            "Time_Body_Gyro_Jerk_Magnitude-std()",
                                            "FourierTrans_Body_Acceleration-mean()-X",
                                            "FourierTrans_Body_Acceleration-mean()-Y",
                                            "FourierTrans_Body_Acceleration-mean()-Z",
                                            "FourierTrans_Body_Acceleration-std()-X",
                                            "FourierTrans_Body_Acceleration-std()-Y",
                                            "FourierTrans_Body_Acceleration-std()-Z",
                                            "FourierTrans_Body_Acceleration_Jerk-mean()-X",
                                            "FourierTrans_Body_Acceleration_Jerk-mean()-Y",
                                            "FourierTrans_Body_Acceleration_Jerk-mean()-Z",
                                            "FourierTrans_Body_Acceleration_Jerk-std()-X",
                                            "FourierTrans_Body_Acceleration_Jerk-std()-Y",
                                            "FourierTrans_Body_Acceleration_Jerk-std()-Z",
                                            "FourierTrans_Body_Gyro-mean()-X",
                                            "FourierTrans_Body_Gyro-mean()-Y",
                                            "FourierTrans_Body_Gyro-mean()-Z",
                                            "FourierTrans_Body_Gyro-std()-X",
                                            "FourierTrans_Body_Gyro-std()-Y",
                                            "FourierTrans_Body_Gyro-std()-Z",
                                            "FourierTrans_Body_Acceleration_Magnitude-mean()",
                                            "FourierTrans_Body_Acceleration_Magnitude-std()",
                                            "FourierTrans_Body_Acceleration_Jerk_Magnitude-mean()",
                                            "FourierTrans_Body_Acceleration_Jerk_Magnitude-std()",
                                            "FourierTrans_Body_Gyro_Magnitude-mean()",
                                            "FourierTrans_Body_Gyro_Magnitude-std()",
                                            "FourierTrans_Body_Gyro_Jerk_Magnitude-mean()",
                                            "FourierTrans_Body_Gyro_Jerk_Magnitude-std()",
                                            "Activity")

# create tidy dataset with means for mean & std cols, by subject and activity type
limitedMelt <- melt(limitedSet, id=c("Subject", "Activity"))
avgData <- dcast(limitedMelt, Subject + Activity ~ variable, mean)
