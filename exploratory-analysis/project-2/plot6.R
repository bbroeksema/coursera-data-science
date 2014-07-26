# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == '06037').
# Which city has seen greater changes over time in motor vehicle emissions?

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

#baltiMoreEmissions <- NEI[fips == '24510', ]
#baltimoreMotorVehicleEmissions <-baltiMoreEmissions[SCC %in% motorVehicleSCC, ]
#baltimoreMotorVehicleEmissionsTotalsByYear <- baltimoreMotorVehicleEmissions[, list(Emissions = sum(Emissions)), by = c('year')]
# For clarity, the following line gives the same results as above three.
baltimoreMotorVehicleEmissionsTotalsByYear <- NEI[fips == '24510' & SCC %in% motorVehicleSCC, list(Emissions = sum(Emissions)), by = c('year')]
baltimoreMotorVehicleEmissionsTotalsByYear$fips <- 'Baltimore'
laCountyVehicleEmissionsTotalsByYear <- NEI[fips == '06037' & SCC %in% motorVehicleSCC, list(Emissions = sum(Emissions)), by = c('year')]
laCountyVehicleEmissionsTotalsByYear$fips <- 'LA County'

data <- rbind(baltimoreMotorVehicleEmissionsTotalsByYear, laCountyVehicleEmissionsTotalsByYear)
png(filename='plot6.png')
g <- ggplot(data, aes(year, Emissions))
g <- g + geom_line() + facet_grid(. ~ fips, scales = 'free_y')
g <- g + labs(title = 'Emissions from Motor Vehicles in Baltimore', y = 'Emissions (tons)')
print(g)
dev.off()

rm(motorVehicleSCC, baltimoreMotorVehicleEmissionsTotalsByYear, g,
   laCountyVehicleEmissionsTotalsByYear, data)
