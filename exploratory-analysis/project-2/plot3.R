# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in
# emissions from 1999–2008 for Baltimore City? Which have seen increases in
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot
# answer this question.

library(ggplot2)
if (!exists(c('NEI', 'SCC'))) {
  if (! "summarySCC_PM25.rds" %in% dir("data"))
    stop("Please download NEI_data.zip and extract the files into a dir called data")
  library(data.table)
  NEI <- data.table(readRDS("data/summarySCC_PM25.rds"))
  SCC <- data.table(readRDS("data/Source_Classification_Code.rds"))
}

totalEmissionsBaltimore <- NEI[fips == "24510", list(Emissions = sum(Emissions)), by = c('year', 'type')]
png(filename="plot3.png")
g <- ggplot(totalEmissionsBaltimore, aes(year, Emissions))
g <- g + geom_line() + facet_grid(. ~ type) + geom_smooth(method = "lm")
g <- g + labs(title = "Emissions per source type", y = "Emissions (tons)")
print(g)
dev.off()

rm(totalEmissionsBaltimore, g)
