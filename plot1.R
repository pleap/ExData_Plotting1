## Require lubridate (for ymd function)
library(lubridate)
## Require dlpyr (for filter function)
library(dplyr)

## Load text file with ; seperator
powerdata<-read.csv("household_power_consumption.txt", sep=";")

## Convert Date to POSIXct Format
powerdata$Date<-dmy(powerdata$Date)

## Filter for the dates request for the plots
dataset<-filter(powerdata, Date == ymd("2007-02-01")| Date == ymd("2007-02-02") )

## Convert factor to numeric
dataset$Global_active_power <- as.numeric(as.character(dataset$Global_active_power))

##  Create Plot1
## Open the png file device
png(file = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12)

##Generate the graph
hist(dataset$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main = "Global Active Power")

##Close the png file device
dev.off()