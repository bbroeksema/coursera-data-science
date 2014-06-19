library(data.table)

# Expected data dir: "./data/UCI HAR Dataset/"

# Read and merge the test data
train_x <- read.table("data//UCI HAR Dataset//train/X_train.txt", header=FALSE)
train_y <- read.table("data//UCI HAR Dataset//train//y_train.txt", header=FALSE)
train_subject <- read.table("data//UCI HAR Dataset//train//subject_train.txt", header=FALSE)
train <- cbind(train_x, train_y, train_subject)
rm(train_x, train_y, train_subject)

# Read and merge the test data
test_x <- read.table("data//UCI HAR Dataset//test/X_test.txt", header=FALSE)
test_y <- read.table("data//UCI HAR Dataset//test//y_test.txt", header=FALSE)
test_subject <- read.table("data//UCI HAR Dataset//test//subject_test.txt", header=FALSE)
test <- cbind(test_x, test_y, test_subject)
rm(test_x, test_y, test_subject)

# Next merge the test and training datasets.
data <- rbind(test, train)
rm(test, train)

# Now extract only the measurements on the mean and standard deviation for each
# measurement.
cols <- c(
    # tBodyAcc-(mean|std)-(X|Y|Z)
    1,2,3,4,5,6,
    # tGravityAcc-(mean|std)-(X|Y|Z)
    41,42,43,44,45,46,
    # tBodyAccJerk-(mean|std)-(X|Y|Z)
    81,82,83,84,85,86,
    # tBodyGyro-(mean|std)-(X|Y|Z)
    121,122,123,124,125,126,
    # tBodyGyroJerk-(mean|std)-(X|Y|Z)
    161,162,163,164,165,166,
    # tBodyAccMag-(mean|std)
    201,202,
    # tGravityAccMag-(mean|std)
    214,215,
    # tBodyAccJerkMag-(mean|std)
    227,228,
    # tBodyGyroMag-(mean|std)
    240,241,
    # tBodyGyroJerkMag-(mean|std)
    253,254,
    # fBodyAcc-(mean|std)-(X|Y|Z)
    266,267,268,269,270,271,
    # fBodyAccJerk-(mean|std)-(X|Y|Z)
    345,346,347,348,349,350,
    # fBodyGyro-(mean|std)-(X|Y|Z)
    424,425,426,427,428,429,
    # fBodyAccMag-(mean|std)
    503,504,
    # fBodyBodyAccJerkMag-(mean|std)
    516,517,
    # fBodyBodyGyroMag-(mean|std)
    529,530,
    # fBodyBodyGyroJerkMag-(mean|std)
    542,543,
    # angle(tBodyAccMean,gravity|tBodyAccJerkMean,gravityMean|tBodyGyroMean,gravityMean|
    #       tBodyGyroJerkMean,gravityMean)|X,gravityMean|Y,gravityMean|Z,gravityMean)
    555,556,557,558,559,560,561,
    # label, subject
    562, 563
)
data <- data[,cols]

# Uses descriptive activity names to name the activities in the data set
activityCol = length(cols) - 1
data[,activityCol] <- cut(data[,activityCol], breaks=6, labels=c("Walking", "Walking upstairs",
                                                                 "Walking downstairs", "sitting",
                                                                 "Standing", "Laying")
)

# Appropriately labels the data set with descriptive variable names.
colnames <- c(
    # tBodyAcc-(mean|std)-(X|Y|Z)
    "Body.Accelleration.X.Mean",
    "Body.Accelleration.Y.Mean",
    "Body.Accelleration.Z.Mean",
    "Body.Accelleration.X.StdDev",
    "Body.Accelleration.Y.StdDev",
    "Body.Accelleration.Z.StdDev",
    # tGravityAcc-(mean|std)-(X|Y|Z)
    "Gravity.Accelleration.X.Mean",
    "Gravity.Accelleration.Y.Mean",
    "Gravity.Accelleration.Z.Mean",
    "Gravity.Accelleration.X.StdDev",
    "Gravity.Accelleration.Y.StdDev",
    "Gravity.Accelleration.Z.StdDev",
    # tBodyAccJerk-(mean|std)-(X|Y|Z)
    "Body.Accelleration.Jerk.X.Mean",
    "Body.Accelleration.Jerk.Y.Mean",
    "Body.Accelleration.Jerk.Z.Mean",
    "Body.Accelleration.Jerk.X.StdDev",
    "Body.Accelleration.Jerk.Y.StdDev",
    "Body.Accelleration.Jerk.Z.StdDev",
    # tBodyGyro-(mean|std)-(X|Y|Z)
    "Body.Gyroscope.X.Mean",
    "Body.Gyroscope.Y.Mean",
    "Body.Gyroscope.Z.Mean",
    "Body.Gyroscope.X.StdDev",
    "Body.Gyroscope.Y.StdDev",
    "Body.Gyroscope.Z.StdDev",
    # tBodyGyroJerk-(mean|std)-(X|Y|Z)
    "Body.Gyroscope.Jerk.X.Mean",
    "Body.Gyroscope.Jerk.Y.Mean",
    "Body.Gyroscope.Jerk.Z.Mean",
    "Body.Gyroscope.Jerk.X.StdDev",
    "Body.Gyroscope.Jerk.Y.StdDev",
    "Body.Gyroscope.Jerk.Z.StdDev",
    # tBodyAccMag-(mean|std)
    "Body.Accelleration.Magnitude.Mean",
    "Body.Accelleration.Magnitude.StdDev",
    # tGravityAccMag-(mean|std)
    "Gravity.Accelleration.Magnitude.Mean",
    "Gravity.Accelleration.Magnitude.StdDev",
    # tBodyAccJerkMag-(mean|std)
    "Body.Accelleration.Jerk.Magnitude.Mean",
    "Body.Accelleration.Jerk.Magnitude.StdDev",
    # tBodyGyroMag-(mean|std)
    "Body.Gyroscope.Magnitude.Mean",
    "Body.Gyroscope.Magnitude.StdDev",
    # tBodyGyroJerkMag-(mean|std)
    "Body.Gyroscope.Jerk.Magnitude.Mean",
    "Body.Gyroscope.Jerk.Magnitude.StdDev",
    # fBodyAcc-(mean|std)-(X|Y|Z)
    "Freq.Body.Accelleration.X.Mean",
    "Freq.Body.Accelleration.Y.Mean",
    "Freq.Body.Accelleration.Z.Mean",
    "Freq.Body.Accelleration.X.StdDev",
    "Freq.Body.Accelleration.Y.StdDev",
    "Freq.Body.Accelleration.Z.StdDev",
    # fBodyAccJerk-(mean|std)-(X|Y|Z)
    "Freq.Body.Accelleration.Jerk.X.Mean",
    "Freq.Body.Accelleration.Jerk.Y.Mean",
    "Freq.Body.Accelleration.Jerk.Z.Mean",
    "Freq.Body.Accelleration.Jerk.X.StdDev",
    "Freq.Body.Accelleration.Jerk.Y.StdDev",
    "Freq.Body.Accelleration.Jerk.Z.StdDev",
    # fBodyGyro-(mean|std)-(X|Y|Z)
    "Freq.Body.Gyroscope.Jerk.X.Mean",
    "Freq.Body.Gyroscope.Jerk.Y.Mean",
    "Freq.Body.Gyroscope.Jerk.Z.Mean",
    "Freq.Body.Gyroscope.Jerk.X.StdDev",
    "Freq.Body.Gyroscope.Jerk.Y.StdDev",
    "Freq.Body.Gyroscope.Jerk.Z.StdDev",
    # fBodyAccMag-(mean|std)
    "Freq.Body.Accelleration.Magnitude.Mean",
    "Freq.Body.Accelleration.Magnitude.StdDev",
    # fBodyBodyAccJerkMag-(mean|std)
    "Freq.Body.Accelleration.Jerk.Magnitude.Mean",
    "Freq.Body.Accelleration.Jerk.Magnitude.StdDev",
    # fBodyBodyGyroMag-(mean|std)
    "Freq.Body.Gyroscope.Magnitude.Mean",
    "Freq.Body.Gyroscope.Magnitude.StdDev",
    # fBodyBodyGyroJerkMag-(mean|std)
    "Freq.Body.Gyroscope.Jerk.Magnitude.Mean",
    "Freq.Body.Gyroscope.Jerk.Magnitude.StdDev",
    # angle(tBodyAccMean,gravity|tBodyAccJerkMean,gravityMean|tBodyGyroMean,gravityMean|
    #       tBodyGyroJerkMean,gravityMean)|X,gravityMean|Y,gravityMean|Z,gravityMean)
    "Angle(Body.Acceleration.Mean, Gravity)",
    "Angle(Body.Acceleration.Jerk.Mean, Gravity.Mean)",
    "Angle(Body.Gyroscope.Mean, Gravity.Mean)",
    "Angle(Body.Gyroscope.Jerk.Mean, Gravity.Mean)",
    "Angle(X, Gravity.Mean)",
    "Angle(Y, Gravity.Mean)",
    "Angle(Z, Gravity.Mean)",
    # label, subject
    "Activity", "Subject"
);
names(data) <- colnames

# Creates a second, independent tidy data set with the average of each variable
# for each activity and each subject.

# FIXME: I guess there are smarter and more elegant ways to do this in stead of
# using nested for loops. I'm running out of time though and this sort of works,
# so I'll keep it like this and will see during the reviews how others did it
# more elegantly (hopefully)

dataBySubject <- split(data, data$Subject)
df <- NULL
for (i in 1:length(dataBySubject)) {
    # For each subject
    dataForSubject <- dataBySubject[[i]]
    dataForSubjectMean <- by(dataForSubject[,1:73], dataForSubject$Activity, function(x) sapply(x, mean))
    for (j in 1:length(dataForSubjectMean)) {
        # For each activity
        activity <- names(dataForSubjectMean[j])
        row <- as.list(dataForSubjectMean[[activity]])
        row$Activity <- activity
        row$Subject <- i
        df <- rbind(df, row)
    }
}

