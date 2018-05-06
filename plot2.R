rm(list=ls())

library(tidyr)
library(dplyr)

# Read data
data <- read.table("household_power_consumption.txt",header=TRUE,sep=";",dec=".",na.strings = "?")

# Unite "Date" column and "Time" column
data <- unite(data,col=Date_Time,Date,Time,sep = " ",remove=TRUE)

# Convert string to date/time
data$Date_Time <- as.POSIXct(strptime(data$Date_Time,"%d/%m/%Y %H:%M:%S"))

# Extract two days data 2007-02-01 and 2007-02-02
data <- filter(data,(Date_Time >= as.POSIXct(strptime("01/02/2007 00:00:00","%d/%m/%Y %H:%M:%S"))) 
               & (Date_Time < as.POSIXct(strptime("03/02/2007 00:00:00","%d/%m/%Y %H:%M:%S"))) )

# Summary data
str(data)
summary(data)


# plot2
plot(data$Date_Time,data$Global_active_power,type="l",main="",xlab="",ylab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot2.png")
dev.off()
