# How have emissions from motor vehicle sources changed from 1999–2008 in
# Baltimore City? 

source("prepareData.R")
library(ggplot2)

# Find all SCC codes that have Motor Vehicle in the Short.Name field
# Note, this results in a somewhat limited data set, but I choose to stay as
# close to the description in the assignment as I could. I'm aware that
# broadening the search term with terms like Auto, Highway, etc. would give a
# broader view of the data and might be considered valid within the terms of the
# question.
motorVehicleSCC <- SCC[grep('Motor Vehicle', Short.Name),]$SCC

#baltiMoreEmissions <- NEI[fips == "24510", ]
#baltimoreMotorVehicleEmissions <-baltiMoreEmissions[SCC %in% motorVehicleSCC, ]
#baltimoreMotorVehicleEmissionsTotalsByYear <- baltimoreMotorVehicleEmissions[, list(Emissions = sum(Emissions)), by = c('year')]
# For clarity, the following line gives the same results as above three.
baltimoreMotorVehicleEmissionsTotalsByYear <- NEI[fips == "24510" & SCC %in% motorVehicleSCC, list(Emissions = sum(Emissions)), by = c('year')]

png(filename="plot5.png")
g <- ggplot(baltimoreMotorVehicleEmissionsTotalsByYear, aes(year, Emissions))
g <- g + geom_line() + geom_smooth(method = "lm")
g <- g + labs(title = "Emissions from Motor Vehicles in Baltimore", y = "Emissions (tons)")
g <- g + annotate("text", x = 2003, y = 10.17, label = "\n\nApparently there is no data for Baltimore\n in 1999 and 2008 on Motor Vehicles.")
print(g)
dev.off()

rm(motorVehicleSCC, baltimoreMotorVehicleEmissionsTotalsByYear, g)
