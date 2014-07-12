source("prepareData.R")

par(mfrow = c(2, 2), bg="white", cex=.8, cex.axis = .8)

# Top left plot
plot(householdData$DateTime, householdData$Global_active_power, xlab="",
     ylab="Global Active Power", pch='.')
lines(householdData$DateTime, householdData$Global_active_power)

# Top right plot
plot(householdData$DateTime, householdData$Voltage, xlab="datetime",
     ylab="Voltage", pch='.')
lines(householdData$DateTime, householdData$Voltage)

# Bottom left plot
plot(householdData$DateTime, householdData$Sub_metering_1, xlab="",
     ylab="Energy sub metering", type="n")

lines(householdData$DateTime, householdData$Sub_metering_1, col="black")
lines(householdData$DateTime, householdData$Sub_metering_2, col="red")
lines(householdData$DateTime, householdData$Sub_metering_3, col="blue")

legend("topright", col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1), bty="n", cex=.8, inset=.1)

# Bottom right plot
plot(householdData$DateTime, householdData$Global_reactive_power,
     xlab="datetime", ylab="Global_reactive_power", pch='.')
lines(householdData$DateTime, householdData$Global_reactive_power)


dev.copy(png, file="plot4.png")
dev.off()