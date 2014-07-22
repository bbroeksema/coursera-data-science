# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a
# plot answering this question.

# Answer: Apperently yes. We plot emissions (y), versus years (x), which gives
#         a plot with two peaks, however the overall trend seems downwards. To
#         further strengthen this observation we add a regression line, which
#         also, shows the downward trend as time goes.

source("prepareData.R")
totalEmissionsBaltimore <- NEI[fips == "24510", list(Emissions = sum(Emissions)), by = year]
png(filename="plot2.png")
with(totalEmissionsBaltimore, {
     plot(year, Emissions, type='n', main = "Total Emissions by Year in Baltimore City",
          ylab = "Emissions (Tons)")
     lines(year, Emissions)
     model <- lm(Emissions ~ year)
     abline(model, lwd = 2, col='blue')
     
  }
)
dev.off()

rm(totalEmissionsBaltimore)
