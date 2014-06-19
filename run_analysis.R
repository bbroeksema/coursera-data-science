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
data[,87] <- cut(data[,87], breaks=6, labels=c("Walking", "Walking upstairs",
                                               "Walking downstairs", "sitting",
                                               "Standing", "Laying")
)