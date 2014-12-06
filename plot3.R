## Require lubridate (for ymd function)
library(lubridate)
## Require dlpyr (for filter & mutate functions?)
library(dplyr)

## Load text file with ; seperator
powerdata<-read.csv("household_power_consumption.txt", sep=";")

## Convert Date to POSIXct Format
powerdata$Date<-dmy(powerdata$Date)

## Create a POSIXct Date/Time Field
powerdata<-mutate(powerdata, datetime = Date + hms(Time))

## Filter for the dates request for the plots
dataset<-filter(powerdata, Date == ymd("2007-02-01")| Date == ymd("2007-02-02") )

## Convert factors to numeric
dataset$Sub_metering_1 <- as.numeric(as.character(dataset$Sub_metering_1))
dataset$Sub_metering_2 <- as.numeric(as.character(dataset$Sub_metering_2))
dataset$Sub_metering_3 <- as.numeric(as.character(dataset$Sub_metering_3))

##  Create Plot3
## Open the png file device
png(file = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12)

##Generate the graph
plot(dataset$datetime, dataset$Sub_metering_1, type="n",xlab="", ylab="Energy sub metering")
points(dataset$datetime, dataset$Sub_metering_1, type="l")
points(dataset$datetime, dataset$Sub_metering_2, type="l", col = "red")
points(dataset$datetime, dataset$Sub_metering_3, type="l", col = "blue")
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1), 
       col=c("black", "red","blue")
       ) 

##Close the png file device
dev.off()
