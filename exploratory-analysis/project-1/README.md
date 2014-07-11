# Introduction

The R scripts in this directory download the household power consumption data
and generate the plots as required for the first project of exploratory data
analysis course.

# prepareData.R

This script prepares the date for which we want to generate the plots. First it
creates a data directory, next it downloads and unzips the file. Finally it
reads in the data and properly deals with missing values.

    Date: Date in format dd/mm/yyyy
    Time: time in format hh:mm:ss
    Global_active_power: household global minute-averaged active power (in kilowatt)
    Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
    Voltage: minute-averaged voltage (in volt)
    Global_intensity: household global minute-averaged current intensity (in ampere)
    Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
    Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
    Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.
