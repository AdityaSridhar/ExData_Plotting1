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

png(filename = "Plot1.png",
    width = 480,
    height = 480,
    units = "px")

hist(subdata$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     col = "red",
     main = "Global Active Power")

dev.off()