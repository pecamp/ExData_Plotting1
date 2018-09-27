###########################################################
# Title: plot2.R
# Author: Philip Camp
#           
# Description:  This script reads in data from 
#               UCI Machine Learning Repo and
#               replicates 2 of 4 assigned plots in 
#               the repo:
#               https://github.com/pecamp/ExData_Plotting1
# 
#               This is plot 2
#               
# Date:         21 September 2018
############################################################

# Clear working environment
rm(list = ls())

# Library necessary packages

# Set data download locations
dataURL         <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

##############################################
# Step 1 - Download, unzip, and read-in data #
##############################################

# Download data to your working directory
download.file(dataURL, destfile = "HouseholdPowerConsume.zip")

# Unzip data
unzip("HouseholdPowerConsume.zip")

# Read-in household power consumption data
myData          <- read.table("household_power_consumption.txt", 
                              header = TRUE, 
                              stringsAsFactors = FALSE,
                              sep = ";")

# Set column classes to the right data type
myData$Date                 <- as.Date(myData$Date, format("%d/%m/%Y"))
myData$Time                 <- format(myData$Time, format="%H:%M:%S")
myData$Global_active_power  <- as.numeric(myData$Global_active_power)
myData$Global_reactive_power<- as.numeric(myData$Global_reactive_power)
myData$Voltage              <- as.numeric(myData$Voltage)
myData$Global_intensity     <- as.numeric(myData$Global_intensity)
myData$Sub_metering_1       <- as.numeric(myData$Sub_metering_1)
myData$Sub_metering_2       <- as.numeric(myData$Sub_metering_2)
myData$Sub_metering_3       <- as.numeric(myData$Sub_metering_3)

# Subset data to desired time range,  2007-02-01 and 2007-02-02
myData                      <- subset(myData, Date >= "2007-02-01" & Date <= "2007-02-02")

##############################################
#           Step 2 - Plot Data               #
##############################################

# The second plot is the Global Active power
# across time starting with Thursday, Friday, then Sat

# Create a time series from the time column
TimeSeries  <- strptime(paste(myData$Date, myData$Time, sep=" "), "%Y-%m-%d %H:%M:%S")

# First try to plot the data using time before we get into axis ticks
png("plot2.png", width = 480, height = 480, units = "px")
plot(TimeSeries, myData$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
