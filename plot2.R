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
data1 <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                    na.strings = "?", colClasses = c("character", "character", "numeric", 
                                                     "numeric", "numeric", "factor", 
                                                     "factor", "factor", "numeric"))


#load dplyr, and filter rows for required dates 
library(dplyr)
data1.subset <- filter(data1, Date %in% c("1/2/2007", "2/2/2007"))

#convert date column to date and class
data1.subset1 <- transform(data1.subset, Date = as.Date(Date, format = "%d/%m/%Y"))

##create a new column called datetime
data1.subset2 <-data1.subset1 %>% 
  mutate(datetime = paste(Date, Time))

#convert datetime column to date-time class
data1.subset2 <- transform(data1.subset2, datetime = 
                             strptime(datetime, "%Y-%m-%d %H:%M:%S"))

#create line plots of date time and global active power and save to png file 
png("plot2.png")
par(mar = c(4,6,2,2))
with(data1.subset2, plot(datetime, Global_active_power, type = "l", 
               ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()
