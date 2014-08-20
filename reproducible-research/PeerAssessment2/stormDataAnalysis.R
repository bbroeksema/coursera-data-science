url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
destFile <- "data/stormData.csv.bz2"
dataFile <- "data/stormData.csv"

if (!file.exists("stormDataAnalysis.R")) {
  stop("Set your working directory to the dir of this script...")
}

if (!file.exists("data")) {
  dir.create("data")
}

if (!file.exists(destFile)) {
  download.file(url, destFile, method="curl")
}

if (!file.exists(dataFile)) {
  system(paste("bunzip2 ", destFile, sep=""))
}

# Read and cleanse the data.
stormData <- read.csv(dataFile, stringsAsFactors=FALSE)

# Fix some issues in the data I found while manually checking results
# First, we make sure that all event types are upper case.
fixNamingIssues <- function(x) {
  x <- toupper(x) # Make sure that all event types are upper case first
  x <- gsub("^\\s+|\\s+$", "", x) # Trim whitespace
  
  # The following statements unify a number of names which are very similar.
  # The strategy I chose was to rename the events with the lowest fequency to
  # those with the highest frequency.
  if (x == "WINTER WEATHER MIX") x <- "WINTER WEATHER"
  else if (x == "WHIRLWIND") x <- "WIND"
  else if (x == "WINTER STORMS") x <- "WINTER STORM"
  else if (x == "WATERSPOUT TORNADO") x <- "WATERSPOUT"
  else if (x == "URBAN AND SMALL STREAM FLOODIN") x <- "URBAN/SML STREAM FLD"
  else if (x == "THUNDERTORM WINDS") x <- "TSTM WIND"
  else if (x == "THUNDERSTORM WINDSS") x <- "TSTM WIND"
  else if (x == "THUNDERSTORM WINDS 13") x <- "TSTM WIND"
  else if (x == "THUNDERSTORM WINDS") x <- "TSTM WIND"
  else if (x == "THUNDERSTORM WINDS/HAIL") x <- "TSTM WIND"
  else if (x == "THUNDERSTORM  WINDS") x <- "TSTM WIND"
  else if (x == "THUNDERSTORM WIND G52") x <- "TSTM WIND"
  else if (x == "THUNDERSTORM WIND (G40)") x <- "TSTM WIND"
  else if (x == "THUNDERSTORMW") x <- "TSTM WIND"
  else if (x == "TSTM WIND/HAIL") x <- "TSTM WIND"
  else if (x == "TSTM WIND (G45)") x <- "TSTM WIND"
  else if (x == "TSTM WIND (G40)") x <- "TSTM WIND"
  else if (x == "TSTM WIND (G35)") x <- "TSTM WIND"
  else if (x == "THUNDERSTORM WIND") x <- "TSTM WIND"
  else if (x == "THUNDERSTORMS WINDS") x <- "TSTM WIND"
  else if (x == "STRONG WINDS") x <- "STRONG WIND"
  else if (x == "STORM SURGE/TIDE") x <- "STORM SURGE"
  else if (x == "SNOW SQUALLS") x <- "SNOW SQUALL"
  else if (x == "RIVER FLOODING") x <- "RIVER FLOOD"
  else if (x == "RIP CURRENTS/HEAVY SURF") x <- "RIP CURRENT"
  else if (x == "RIP CURRENTS") x <- "RIP CURRENT"
  else if (x == "RECORD HEAT") x <- "EXCESSIVE HEAT"
  else if (x == "RECORD/EXCESSIVE HEAT") x <- "EXCESSIVE HEAT"
  else if (x == "RECORD COLD") x <- "EXTREME COLD"
  else if (x == "EXTREME HEAT") x <- "EXCESSIVE HEAT"
  else if (x == "HEAT WAVES") x <- "HEAT"
  else if (x == "HEAT WAVE DROUGHT") x <- "HEAT"
  else if (x == "HEAT WAVE") x <- "HEAT"
  else if (x == "EXTREME HEAT") x <- "HEAT"
  else if (x == "HEAVY RAINS") x <- "HEAVY RAIN"
  else if (x == "WINDS") x <- "WIND"
  else if (x == "WIND STORM") x <- "WIND"
  else if (x == "WILD/FOREST FIRE") x <- "WILDFIRE"
  else if (x == "WILD FIRES") x <- "WILDFIRE"
  else if (x == "UNSEASONABLY WARM AND DRY") x <- "UNSEASONABLY WARM"
  else if (x == "AVALANCE") x <- "AVALANCHE"
  else if (x == "COASTAL FLOODING") x <- "COASTAL FLOOD"
  else if (x == "COASTAL FLOODING/EROSION") x <- "COASTAL FLOOD"
  else if (x == "COASTALSTORM") x <- "COASTAL STORM"
  else if (x == "COLD AND SNOW") x <- "COLD"
  else if (x == "COLD TEMPERATURE") x <- "COLD"
  else if (x == "COLD WAVE") x <- "COLD"
  else if (x == "COLD WEATHER") x <- "COLD"
  else if (x == "COLD/WINDS") x <- "COLD/WIND CHILL"
  else if (x == "EXCESSIVE HEAT") x <- "EXCESSIVE HEAT"
  else if (x == "DROUGHT") x <- "EXCESSIVE HEAT"
  else if (x == "DRY MIRCOBURST WINDS") x <- "DRY MICROBURST"
  else if (x == "DUST DEVIL") x <- "DUST STORM"
  else if (x == "WINTRY MIX") x <- "WINTER WEATHER"
  else if (x == "WINTER WEATHER/MIX") x <- "WINTER WEATHER"
  else if (x == "WINTER STORM HIGH WINDS") x <- "WINTER STORM"
  else if (x == "WATERSPOUT/TORNADO") x <- "WATERSPOUT"
  else if (x == "WARM WEATHER") x <- "EXCESSIVE HEAT"
  else if (x == "TROPICAL STORM GORDON") x <- "TROPICAL STORM"
  else if (x == "TORNADO F3") x <- "TORNADO"
  else if (x == "TORNADO F2") x <- "TORNADO"
  else if (x == "TORNADOES, TSTM WIND, HAIL") x <- "TORNADO"
  else if (x == "HYPOTHERMIA") x <- "HYPOTHERMIA/EXPOSURE"
  else if (x == "HYPERTHERMIA/EXPOSURE") x <- "HYPOTHERMIA/EXPOSURE"
  else if (x == "LIGHTNING.") x <- "LIGHTNING"
  else if (x == "LANDSLIDES") x <- "LANDSLIDE"
  else if (x == "ICE ROADS") x <- "ICE"
  else if (x == "ICE ON ROAD") x <- "ICE"
  else if (x == "HEAVY SNOW SHOWER") x <- "HEAVY SNOW"
  else if (x == "HEAVY SNOW/ICE") x <- "HEAVY SNOW"
  else if (x == "HEAVY SNOW/BLIZZARD/AVALANCHE") x <- "HEAVY SNOW"
  else if (x == "HEAVY SNOW AND HIGH WINDS") x <- "HEAVY SNOW"
  else if (x == "GUSTY WIND") x <- "GUSTY WINDS"
  else if (x == "GLAZE/ICE STORM") x <- "GLAZE"
  else if (x == "FOG AND COLD TEMPERATURES") x <- "FOG"
  else if (x == "FLOOD/RIVER FLOOD") x <- "FLOOD"
  else if (x == "FLOODING") x <- "FLOOD"
  else if (x == "FLOOD & HEAVY RAIN") x <- "FLOOD"
  else if (x == "FLOOD/FLASH FLOOD") x <- "FLOOD"
  else if (x == "FLASH FLOODS") x <- "FLASH FLOOD"
  else if (x == "FLASH FLOODING/FLOOD") x <- "FLASH FLOOD"
  else if (x == "FLASH FLOODING") x <- "FLASH FLOOD"
  else if (x == "FLASH FLOOD/FLOOD") x <- "FLASH FLOOD"
  
  
  x
}

stormData$EVTYPE <- sapply(stormData$EVTYPE, fixNamingIssues)
stormData$EVTYPE <- as.factor(stormData$EVTYPE)

### First we look at injuries and fatalities.

# > sum(is.na(stormData$FATALITIES))
# [1] 0
# Good, we don't have missing data for fatalities

# > sum(is.na(stormData$INJURIES))
# [1] 0
# Good, we don't have missing data for injuries either
