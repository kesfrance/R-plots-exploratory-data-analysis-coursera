#!/usr/bin/R
#
# A script to analyse data and plot a histogram
#
# by: Francis Kessie
#
#
# This script works on household_power_consumption.txt 
# dataset obtained from the the UC Irvine Machine Learning 
# Repository. 

# requires dplyr package to run

# 
#
#read dataset and store in variable called data1
data2 <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                    na.strings = "?", colClasses = c("factor", "factor", "numeric", 
                                                     "numeric", "numeric", "factor", 
                                                     "factor", "factor", "numeric"))

#load dplyr, and filter rows for required dates 
library(dplyr)
data2.subset <- filter(data2, Date %in% c("1/2/2007", "2/2/2007"))

#Create a histogram of global active power
png("plot1.png")
par(mar = c(6,6,2,2))

hist(data2.subset$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)" )
dev.off()
