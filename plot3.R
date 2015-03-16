#!/usr/bin/R
#
# A script to analyse data and plot a graph
#
# by: Francis Kessie
#
#
# This script works on household_power_consumption.txt 
# datset obtained from the the UC Irvine Machine Learning 
# Repository. 

# requires dplyr package to run

#read dataset and store in variable called data1
data3 <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                    na.strings = "?", colClasses = c("character", "character", "numeric", 
                                                     "numeric", "numeric", "factor", 
                                                     "numeric", "numeric", "numeric"))


#load dplyr, and filter rows for required dates 
library(dplyr)
data3.subset <- filter(data3, Date %in% c("1/2/2007", "2/2/2007"))

#convert date column to date and class
data3.subset1 <- transform(data3.subset, Date = as.Date(Date, format = "%d/%m/%Y"))

##create a new column called datetime
data3.subset1 <-data3.subset1 %>% 
  mutate(datetime = paste(Date, Time))

#convert datetime column to date-time class
data3.subset1 <- transform(data3.subset1, datetime = 
                             strptime(datetime, "%Y-%m-%d %H:%M:%S"))


#create line plots of date time and global active power and save to png file 
png("plot3.png")
par(mar = c(4,6,2,2))
with(data3.subset1, plot(datetime, Sub_metering_1, type = "l",
                         ylab = "Energy sub metering", xlab = ""))
with(data3.subset1, points(datetime, Sub_metering_2, type = "l", col = "red"))
with(data3.subset1, points(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", pch = "_", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_2"))
dev.off()
