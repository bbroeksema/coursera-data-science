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

data <- rbind(test, train)
rm(test, train)
