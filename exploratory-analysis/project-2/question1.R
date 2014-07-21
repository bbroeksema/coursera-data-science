# Have total emissions from PM2.5 decreased in the United States from 1999 to
# 2008? Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

source("prepareData.R")
totalEmissionForAllSources <- NEI[,list(Emission = sum(Emissions)), by = year]
myTicks <- c(3500000, 4000000, 5000000, 6000000, 7000000)
with(totalEmissionForAllSources, {
     plot(year, Emission, type='n', main = "Total Emissions by Year",
          yaxt="n", ylim = range(myTicks), ylab = "Emissions (Milions of tons)")
     axis(2, at=myTicks, labels=c('3.5M', '4M', '5M','6M','7M'))
     lines(year, Emission)
  }
)