# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?

# Okay, first we need a list of coal combustion related sources. Let's grep
# around a bit in the SCC table:

source("prepareData.R")
library(ggplot2)
library(scales)

coalCombustionRelatedSources <- SCC[grep('.*Comb.*Coal.*', Short.Name),]

# Now filter the NEI data based on the sources we just found
coalCombustionRelatedEmissions <- NEI[SCC %in% coalCombustionRelatedSources$SCC,]
totalCoalCombustionRelatedEmissions <- NEI[,list(Emissions = sum(Emissions)), by = year]

# A helper function to format y-axis tick marks. Proudly stolen from SO:
# http://stackoverflow.com/questions/10762287/how-can-i-format-axis-labels-with-exponents-with-ggplot2-and-scales
scientific_10 <- function(x) {
  parse(text=gsub("e", " %*% 10^", scientific_format()(x)))
}

png(filename="plot4.png")
g <- ggplot(totalCoalCombustionRelatedEmissions, aes(year, Emissions))
g <- g + geom_line() + geom_smooth(method = "lm")
g <- g + labs(title = "Emissions from coal combustion related sources", y = "Emissions (tons)")
g <- g + scale_y_continuous(labels = scientific_10)
print(g)
dev.off()

rm(coalCombustionRelatedSources, coalCombustionRelatedEmissions,
   totalCoalCombustionRelatedEmissions, g, scientific_10)