###########################################################
# Title: plot4.R
# Author: Philip Camp
#           
# Description:  This script reads in data from 
#               UCI Machine Learning Repo and
#               replicates 4 of 4 assigned plots in 
#               the repo:
#               https://github.com/pecamp/ExData_Plotting1
# 
#               This is plot 4
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

# The fourth plot is plot 2 and 3 in the left column 
# with Voltage and Global reactive power in the right column
# all with TimeSeries on the x-axis

# Create a time series from the time column
TimeSeries  <- strptime(paste(myData$Date, myData$Time, sep=" "), "%Y-%m-%d %H:%M:%S")

# PNG plots
png("plot4.png", width = 480, height = 480, units = "px")

# Change the graphical parameters to plot 4 plots
par(mfrow = c(2,2))

# Plot plot2, note: without the units
plot(TimeSeries, myData$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

# Plot Voltage over TimeSeries, note: datetime is the x-axis label
plot(TimeSeries, myData$Voltage, xlab = "datetime", ylab = "Voltage", type = "l", col = "black")

# Plot plot3, note: legend doesn't have a boundary
plot(TimeSeries, myData$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(TimeSeries, myData$Sub_metering_2, col = "red")
lines(TimeSeries, myData$Sub_metering_3, col = "blue")
legend("topright", lty = rep(1, 3), col = c("black", "red", "blue"), legend = colnames(myData)[7:9], bty = "n")

# Plot Global reactive power in the last plot
plot(TimeSeries, myData$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "l")
dev.off()
