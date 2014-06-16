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
# tBodyAcc-(mean|std)-(X|Y|Z)
# tGravityAcc-(mean|std)-(X|Y|Z)
# tBodyAccJerk-(mean|std)-(X|Y|Z)
# tBodyGyro-(mean|std)-(X|Y|Z)
# tBodyGyroJerk-(mean|std)-(X|Y|Z)
# tBodyAccMag-(mean|std)
# tGravityAccMag-(mean|std)
# tBodyAccJerkMag-(mean|std)
# tBodyGyroMag-(mean|std)
# tBodyGyroJerkMag-(mean|std)
# fBodyAcc-(mean|std|meanFreq)-(X|Y|Z)
# fBodyAccJerk-(mean|std|meanFreq)-(X|Y|Z)
# fBodyGyro-(mean|std|meanFreq)-(X|Y|Z)
# fBodyAccMag-(mean|std|meanFreq)
# fBodyBodyAccJerkMag-(mean|std|meanFreq)
# fBodyBodyGyroMag-(mean|std|meanFreq)
# fBodyBodyGyroJerkMag-(mean|std|meanFreq)
# angle(tBodyAccMean,gravity|tBodyAccJerkMean,gravityMean|tBodyGyroMean,gravityMean|
#       tBodyGyroJerkMean,gravityMean)|X,gravityMean|Y,gravityMean|Z,gravityMean)
# label, subject

cols <- c(1,2,3,4,5,6,
          41,42,43,44,45,46,
          81,82,83,84,85,86,
          121,122,123,124,125,126,
          161,162,163,164,165,166,
          201,202,
          214,215,
          227,228,
          240,241,
          253,254,
          266,267,268,269,270,271,294,295,296,
          345,346,347,348,349,350,373,374,375,
          424,425,426,427,428,429,452,453,453,
          503,504,513,
          516,517,526,
          529,530,539,
          542,543,552,
          555,556,557,558,559,560,561,
          562, 563)
data <- data[,cols]

# Uses descriptive activity names to name the activities in the data set
data[,87] <- cut(data[,87], breaks=6, labels=c("Walking", "Walking upstairs",
                                               "Walking downstairs", "sitting",
                                               "Standing", "Laying")
)
