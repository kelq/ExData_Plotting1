#####
# EDA - Course Project 1
#####

# Include required libraries.
library(data.table)

# Set YOUR working directory here.
setwd("C:/Users/kelvinq/Documents/Coursera/04_EDA/Assignment1")

# Read just the Date field to check where the required rows start and end  (start of 1/2/2007 and right before 3/2/2007).
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
# Plot 4 - Multiple base plots 
###
temper$DT<-as.POSIXct(paste(temper$Date, temper$Time), format="%d/%m/%Y %H:%M:%S")

png(file="plot4.png",width=480, height=480)
par(mfrow = c(2,2))
with(temper, {
  plot(type="l", x=DT, y=Global_active_power, ylab="Global Active Power", xlab="" )
  
  plot(type="l", x=DT, y=Voltage, ylab="Voltage", xlab="datetime")
  
  plot(type="l", y=Sub_metering_1, x=DT, ylab="Energy sub metering", xlab="")
  with(temper, lines(y=Sub_metering_2, x=DT, col="red"))
  with(temper, lines(y=Sub_metering_3, x=DT, col="blue"))
  legend("topright" , bty="n", lty=1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(type="l", x=DT, y=Global_reactive_power, xlab="datetime")
})
dev.off()
