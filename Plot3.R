powerdatafile <- "household_power_consumption.txt"

if (!file.exists(powerdatafile))
{
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile = "PowerData.zip")
    unzip("PowerData.zip",files = powerdatafile)
}

headData <- read.table(file = powerdatafile,
                       header = T,
                       nrow = 1,
                       sep =";")

dataColClasses <- sapply(headData, class)
dataColNames <- names(dataColClasses)

mydata <- read.table(file = "household_power_consumption.txt", 
                     header = T, 
                     sep = ";", 
                     na.strings = "?",
                     stringsAsFactors = F,
                     colClasses = dataColClasses,
                     col.names = dataColNames)

subdata <- subset(mydata, mydata$Date == "1/2/2007" | mydata$Date == "2/2/2007")

datetime <- paste(subdata$Date, subdata$Time)
datetime <- strptime(datetime, format = "%d/%m/%Y %H:%M:%S")
subdata <- cbind(subdata, datetime)

png(filename = "Plot3.png",
    width = 480,
    height = 480,
    units = "px")

plot(datetime, subdata$Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab = "")
lines(datetime, subdata$Sub_metering_2, col = "red")
lines(datetime, subdata$Sub_metering_3, col = "blue")
legend("topright", legend = names(subdata[,7:9]), col = c("black","blue","red"), lty = 1)

dev.off()