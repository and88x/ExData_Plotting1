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
png("figure/plot1.png", width = 480, height = 480)
hist(data$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", 
     col  = 'red', 
     main = "Global Active Power")
dev.off()