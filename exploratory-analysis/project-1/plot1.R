source("prepareData.R")
par(bg="transparent")
hist(householdData$Global_active_power,
     col="red", 
     main="Global Active Power",
     xlab="Global Active Power (Kilowatts)"
)
dev.copy(png, file="plot1.png")
dev.off()