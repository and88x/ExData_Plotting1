#*************************************************************
# Author: Andres Fernando Garcia Calle
# email: fernando.garcia@exatec.tec.mx
# date: 12/10/2020
#*************************************************************
# Dataset: Electric power consumption 
#
# Description: Measurements of electric power consumption in one 
#              household with a one-minute sampling rate over a 
#              period of almost 4 years. Different electrical 
#              quantities and some sub-metering values are 
#              available.
#
#-------------------------------------------------------------
# Load the libraries
library(data.table)
library(dplyr)
#
# Donwload the dataset
#
url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
if (!file.exists('./exdata_data_household_power_consumption.zip')){
  download.file(url,'./exdata_data_household_power_consumption.zip', mode = 'wb')
  unzip("exdata_data_household_power_consumption.zip", exdir = getwd())
}
#
# Load the dataset to workspace
#
cNames <- c("Date","Time","Global_active_power",
            "Global_reactive_power","Voltage",
            "Global_intensity","Sub_metering_1",
            "Sub_metering_2","Sub_metering_3")
#
data <- fread(file       = "household_power_consumption.txt",
              sep        = ";",
              skip       = 66637,
              header     = FALSE,
              col.names  = cNames,
              na.strings = "?",
              nrows      = 69517-66637)
#
# Transform Date/Time characters to "POSIXlt" "POSIXt" objects
times <- paste(data$Date, data$Time) %>% strptime("%d/%m/%Y %H:%M:%S")
#
# Construct the plot
#
png("figure/plot4.png", width = 480, height = 480)
#
par(mfrow = c(2, 2))
#
# Plot 1
with(data, plot(times, Global_active_power,
                type = "l",
                ylab = "Global Active Power",
                xlab = ""))
#
# Plot 2
with(data, plot(times, Voltage,
                type = "l",
                ylab = "Voltage",
                xlab = "datetimes"))
#
# Plot 3
with(data, plot(times, Sub_metering_1,
                type = "l",
                ylab = "Energy sub metering",
                xlab = ""))
lines(times, data$Sub_metering_2,
      col  = 'red')
lines(times, data$Sub_metering_3,
      col  = 'blue')
legend("topright", 
       col     = c("black", "blue", "red"), 
       legend  = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty     = c(1,1,1),
       box.lty = 0,
       inset   = .02)
#
# Plot 4
with(data, plot(times, Global_reactive_power,
                lwd  = 0.1,
                type = "l",
                ylab = "Global_reactive_power",
                xlab = "datetimes"))
points(times, data$Global_reactive_power, pch = 20, cex= 0.4)
#
dev.off()


