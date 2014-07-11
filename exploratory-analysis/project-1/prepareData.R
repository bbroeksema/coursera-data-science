library(data.table)

dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataDir <- "data"
dataZipped <- paste(dataDir, "househould_power_consumption.zip", sep="/")
dataUnzipped <- paste(dataDir, "household_power_consumption.txt", sep="/")

if (!file.exists(dataDir)) {
    print("* Creating data directory...")
    dir.create(dataDir)
}

if (!file.exists(dataZipped)) {
    print("* Downloading file...")
    download.file(dataUrl, dataZipped, method="curl")
}

if (!file.exists(dataUnzipped)) {
    print("* Unzipping file...")
    unzip(dataZipped, exdir=dataDir)
}

if (is.null(householdData)) {
    # Prepare the data for plotting
    householdData <- fread(dataUnzipped, na.strings="?")

    # First filter only on date to speed up the processing.
    householdData$Date <- as.Date(householdData$Date, "%d/%m/%Y")
    householdData <- householdData[Date >= as.Date("2007/02/01") 
                                   & Date <= as.Date("2007/02/02"),]

    # Now combine date and time into one date/time object
    householdData$DateTime <- as.POSIXct(
        paste(householdData$Date, householdData$Time),
        format="%Y-%m-%d %H:%M:%S")

    # Put the DateTime column on the first postion
    householdData$Date <- NULL
    householdData$Time <- NULL
    setcolorder(householdData, 
                c("DateTime","Global_active_power", "Global_reactive_power",
                  "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                  "Sub_metering_3"))
    
    # Convert remaining columns to correct type
    householdData$Global_active_power <- as.numeric(householdData$Global_active_power)
    householdData$Global_reactive_power <- as.numeric(householdData$Global_reactive_power)
    householdData$Voltage <- as.numeric(householdData$Voltage)
    householdData$Global_intensity <- as.numeric(householdData$Global_intensity)
    householdData$Sub_metering_1 <- as.numeric(householdData$Sub_metering_1)
    householdData$Sub_metering_2 <- as.numeric(householdData$Sub_metering_2)
    householdData$Sub_metering_3 <- as.numeric(householdData$Sub_metering_3)
}



# We no longer need thos, clean up the workspace.
rm(dataUrl, dataDir, dataZipped, dataUnzipped)