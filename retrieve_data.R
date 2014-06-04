# This function is responsible for retrieving the raw data. It will create a
# data directory, download and then upzip the data.
#
# Notes:
# * when there is already a zip file, the download will not be initiated
# * when the file is already unzipped, it will not be unzipped again.
#
# See also: cleanData
retrieveData <- function() {
    # Add a safety check, we want to make sure that we're not messing up some
    # other project or user data.
    if (!file.exists("run_analysis.R")) {
        stop("Please set your working directory to the directory that contains the file run_analysis.R")
    }

    if (file.exists("data")) {
        message("Data directory - already exists")
    } else {
        message("Data directory - creating...")
        dir.create("data")
        message("Data directory - done")
    }
    
    # Check if we already have downloaded the data and don't initiate  a
    # download if this is the case.
    filename <-Sys.glob("./data/uci-har-data-*.zip") 
    if (length(filename) == 0) {
        message("Data  download - starting (this may take a while)...")
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        date <- format(Sys.time(), "%d-%m-%Y-%H:%M:%S")
        filename <- paste("./data/uci-har-data-", date, ".zip", sep="")
        download.file(url, filename, method="curl", quiet=TRUE)
        message("Data  download - done")
    } else {
        message(paste("Data  download - already downloaded: ", filename, sep=""))
    }
    
    if (file.exists("./data/UCI HAR Dataset")) {
        message("Data     unzip - already unzipped")
    } else {
        message("Data     unzip - starting...")
        unzip(filename, exdir="./data")
        message("Data     unzip - done")
    }
}

# This function will remove the data directory in order to perform the full
# analysis from skratch.
cleanData <- function() {
    # Add a safety check, we want to make sure that we're not messing up some
    # other project or user data.
    if (!file.exists("run_analysis.R")) {
        stop("Please set your working directory to the directory that contains the file run_analysis.R")
    }
    answer <- readline("Are you sure that you want to remove data directory [y/n]?")
    if (answer %in% c("y", "Y", "yes")) {
        message("Removing data - starting...")
        unlink("./data", recursive=TRUE, force=TRUE)
        message("Removing data - done")
    } else {
        message("Removing data - canceled")
    }
}
