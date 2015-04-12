#####
# EDA - Course Project 1
#####

# Include required libraries.
library(data.table)

# Set working directory.
setwd("C:/Users/kelvinq/Documents/Coursera/04_EDA/Assignment1")

# Read just the Date field to check where the required rows start and end.
# This takes advantage of the fact that the household data file is sorted by Date.
temper<-fread("household_power_consumption.txt", select=1)
startAt<-min(which(temper$Date=="1/2/2007"))
endAt<-min(which(temper$Date=='3/2/2007'))

# Read file
temper<-NULL
temper<-fread("household_power_consumption.txt", sep=";", skip=startAt, nrows=(endAt-startAt), header=FALSE)

# Somehow, fread function loses the column names when you use the skip clause.
# To re-read file's column names, and assign to data frame.
colNames<-names(read.table("household_power_consumption.txt", nrows=1, sep=";", header=TRUE))
setnames(temper, colNames)

###
# Plot 1 - Histogram of Global Active Powers
###
png(file="plot1.png",width=480, height=480)
hist(temper$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab ="Frequency")
dev.off()
