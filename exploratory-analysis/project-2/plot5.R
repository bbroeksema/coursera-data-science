# How have emissions from motor vehicle sources changed from 1999–2008 in
# Baltimore City? 

library(ggplot2)
if (!exists(c('NEI', 'SCC'))) {
  if (! "summarySCC_PM25.rds" %in% dir("data"))
    stop("Please download NEI_data.zip and extract the files into a dir called data")
  library(data.table)
  NEI <- data.table(readRDS("data/summarySCC_PM25.rds"))
  SCC <- data.table(readRDS("data/Source_Classification_Code.rds"))
}

# I tried various grep patterns, but Vehicle seems to cover the question quite
# well.
motorVehicleSCC <- SCC[grep('Vehicle', Short.Name),]$SCC

#baltiMoreEmissions <- NEI[fips == "24510", ]
#baltimoreMotorVehicleEmissions <-baltiMoreEmissions[SCC %in% motorVehicleSCC, ]
#baltimoreMotorVehicleEmissionsTotalsByYear <- baltimoreMotorVehicleEmissions[, list(Emissions = sum(Emissions)), by = c('year')]
# For clarity, the following line gives the same results as above three.
baltimoreMotorVehicleEmissionsTotalsByYear <- NEI[fips == "24510" & SCC %in% motorVehicleSCC, list(Emissions = sum(Emissions)), by = c('year')]

png(filename="plot5.png")
g <- ggplot(baltimoreMotorVehicleEmissionsTotalsByYear, aes(year, Emissions))
g <- g + geom_line() + geom_smooth(method = "lm")
g <- g + labs(title = "Emissions from Motor Vehicles in Baltimore", y = "Emissions (tons)")
print(g)
dev.off()

rm(motorVehicleSCC, baltimoreMotorVehicleEmissionsTotalsByYear, g)
