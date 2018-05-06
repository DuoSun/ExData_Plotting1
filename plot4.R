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


# plot4
par(mfrow = c(2, 2))

hist(data$Global_active_power,main="Global Active Power",xlab = "Global Active Power (kilowatts)",col="red");

plot(data$Date_Time, data$Voltage, type = "l",xlab="datetime",ylab = "Voltage")

with(data, plot(Date_Time, Sub_metering_1, type = "l",xlab="",ylab = "Energy sub metering"))
with(data, lines(Date_Time, Sub_metering_2, col = "red"))
with(data, lines(Date_Time, Sub_metering_3, col = "blue"))
legend("topright", lwd=2, col = c("black","blue", "red"), cex=0.8,bty = "n",legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

plot(data$Date_Time, data$Global_reactive_power, type = "l",xlab="datetime",ylab = "Global_reactive_power")

dev.copy(png, file = "plot4.png")
dev.off()
