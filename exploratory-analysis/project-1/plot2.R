source("prepareData.R")
par(bg="transparent")
plot(householdData$DateTime, householdData$Global_active_power,
     xlab="",
     ylab="Global Active Power (Kilowatts)", type="n")
lines(householdData$DateTime, householdData$Global_active_power)
dev.copy(png, file="plot2.png")
dev.off()