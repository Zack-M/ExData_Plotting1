### EDA of Electric power consumption data (UCI ML repository) ###

## Set wd here ##
setwd("/Users/R")

## Install all reqd packages (if not already) ##

# All reqd libraries here
library(data.table)
library(sqldf)
library(lubridate)
library(dplyr)


# Read in a sample for investigating data str 
sample1 <- fread("household_power_consumption.txt", sep="auto", nrows=1000, header=TRUE)
str(sample1)

## Read entire dataset using 'fread'
# colClasses won't be set due to '?' symbols
powcon <- fread("household_power_consumption.txt", sep="auto", nrows=-1, header=TRUE, stringsAsFactors = FALSE)

# Set Date colClass to Date format
powcon$Date <- as.Date(powcon$Date, "%d/%m/%Y")

# Subset data with reqd dates to make R run more efficiently
subpowcon <- powcon %>% filter(Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Create DateTime column to convert Time colClass to Date (POSIX)
DateTime <- paste(as.character(subpowcon$Date), subpowcon$Time)
subpowcon$DateTime <- strptime(DateTime, "%Y-%m-%d %H:%M:%S")


#Convert colClasses of the subset (subpowcon)
subpowcon$Global_active_power <- as.numeric(subpowcon$Global_active_power)
subpowcon$Global_reactive_power <- as.numeric(subpowcon$Global_reactive_power)
subpowcon$Voltage <- as.numeric(subpowcon$Voltage)
subpowcon$Global_intensity <- as.numeric(subpowcon$Global_intensity)
subpowcon$Sub_metering_1 <- as.numeric(subpowcon$Sub_metering_1)
subpowcon$Sub_metering_2 <- as.numeric(subpowcon$Sub_metering_2)
subpowcon$Sub_metering_3 <- as.numeric(subpowcon$Sub_metering_3)

submetering <- subpowcon[,7:10]

## Plotting "plot2.png" ##
# create & name .png file, specify image dimensions
png(filename = "plot2.png", width = 480, height = 480, units = "px", type = "quartz")

# set colClass to POSIXlt for time series plotting
subpowcon$DateTime <- as.POSIXlt(subpowcon$DateTime, "%Y-%m-%d %H:%M:%S", tz="UTC")

# Specify plot params & characterstics
plot(subpowcon$DateTime, subpowcon$Global_active_power, type='l', xlab="", ylab="Global Active Power (kilowatts)")

# switching the graphics device off
dev.off()

