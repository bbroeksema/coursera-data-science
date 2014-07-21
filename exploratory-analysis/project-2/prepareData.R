library(data.table)

if (!file.exists('prepareData.R'))
  stop('Please set you working directory to the toplevel directory of this project')

dataUrl <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dataDir <- "data"
dataZipped <- paste(dataDir, "NEI_data.zip", sep="/")
dataFileSCC <- paste(dataDir, "Source_Classification_Code.rds", sep="/")
dataFileNEI <- paste(dataDir, "summarySCC_PM25.rds", sep="/")

if (!file.exists(dataDir)) {
  print("* Creating data directory...")
  dir.create(dataDir)
  download.file(dataUrl, dataZipped, method="curl")
  unzip(dataZipped, exdir=dataDir)
}

if (!file.exists(dataFileSCC)) {
  print("* Unzipping file...")
  unzip(dataZipped, exdir=dataDir)
}

library(data.table)
if (!exists(c('NEI', 'SCC'))) {
  NEI <- data.table(readRDS(dataFileNEI))
  SCC <- data.table(readRDS(dataFileSCC))
  NEI$Pollutant <- as.factor(NEI$Pollutant)
  NEI$type <- as.factor(NEI$type)
}
  
rm(dataUrl, dataDir, dataZipped, dataFileSCC, dataFileNEI)
