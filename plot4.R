#!/usr/bin/R
#
# A script to analyse data and plot multiple graphs
#
# by: Francis Kessie
#
#
# This script works on household_power_consumption.txt 
# datset obtained from the the UC Irvine Machine Learning 
# Repository. 

# requires dplyr package to run


#read dataset and store in variable called data1
data4 <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                    na.strings = "?", colClasses = c("character", "character", "numeric", 
                                                     "numeric", "numeric", "factor", 
                                                     "numeric", "numeric", "numeric"))
#load dplyr, and filter rows for required dates 
library(dplyr)
data4.subset <- filter(data4, Date %in% c("1/2/2007", "2/2/2007"))

#convert date column to date and class
data4.subset1 <- transform(data4.subset, Date = as.Date(Date, format = "%d/%m/%Y"))

##create a new column called datetime
data4.subset1 <-data4.subset1 %>% 
  mutate(datetime = paste(Date, Time))

#convert datetime column to date-time class
data4.subset1 <- transform(data4.subset1, datetime = 
                             strptime(datetime, "%Y-%m-%d %H:%M:%S"))

#set multiple panel, create plots and save to png file 
png("plot4.png")
par(mfcol = c(2,2), mar = c(6,6,2,2))

#create plot of datetime and global active power
with(data4.subset1, plot(datetime, Global_active_power, type = "l", 
                         ylab = "Global Active Power", xlab = ""))

#create plot of datetime and Sub metering
with(data4.subset1, plot(datetime, Sub_metering_1, type = "l",
                         ylab = "Energy sub metering", xlab = ""))
with(data4.subset1, points(datetime, Sub_metering_2, type = "l", col = "red"))
with(data4.subset1, points(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", pch = "_", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_2"))

#create plot of datetime and voltage 
with(data4.subset1, plot(datetime, Voltage, type = "l", 
                         ylab = "Voltage"))

#create plot of datetime and Global reactive power
with(data4.subset1, plot(datetime, Global_reactive_power, type = "l"))
dev.off()
