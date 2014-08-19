url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
destFile <- "data/stormData.csv.bz2"
dataFile <- "data/stormData.csv"

if (!file.exists(destFile)) {
  download.file(url, destFile, method="curl")
}

if (!file.exists(dataFile)) {
  system(paste("bunzip2 ", destFile, sep=""))
}

stormData <- read.csv(dataFile)
