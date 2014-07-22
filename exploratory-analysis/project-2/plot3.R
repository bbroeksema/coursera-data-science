# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in
# emissions from 1999–2008 for Baltimore City? Which have seen increases in
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot
# answer this question.

source("prepareData.R")
library(ggplot2)

totalEmissionsBaltimore <- NEI[fips == "24510", list(Emissions = sum(Emissions)), by = c('year', 'type')]
png(filename="plot3.png")
g <- ggplot(totalEmissionsBaltimore, aes(year, Emissions))
g <- g + geom_line() + facet_grid(. ~ type) + geom_smooth(method = "lm")
g <- g + labs(title = "Emissions per source type", y = "Emissions (tons)")
print(g)
dev.off()

rm(totalEmissionsBaltimore, g)
