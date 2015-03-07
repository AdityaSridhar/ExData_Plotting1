# Name of the file containing the data. 
powerdatafile <- "household_power_consumption.txt"

# Check if file exists on disk, otherwise download the file from the server and unzip it. 
if (!file.exists(powerdatafile))
{
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile = "PowerData.zip")
    unzip("PowerData.zip",files = powerdatafile)
}

# Read one row of the data. The objective is to get the names of the columns and classes of the columns.
headData <- read.table(file = powerdatafile,
                       header = T,
                       nrow = 1,
                       sep =";")

dataColClasses <- sapply(headData, class)
dataColNames <- names(dataColClasses)

# Read the data as a table. 
# 1. Using the column classes determined in the previous step speedens up the process. 
# 2. ? is the NA string for this data set. 
# 3. ; is the seperator.
mydata <- read.table(file = "household_power_consumption.txt", 
                     header = T, 
                     sep = ";", 
                     na.strings = "?",
                     stringsAsFactors = F,
                     colClasses = dataColClasses,
                     col.names = dataColNames)

# Take the subset of the data that corresponds to Feb-02 2007 and Feb-01 2007.
subdata <- subset(mydata, mydata$Date == "1/2/2007" | mydata$Date == "2/2/2007")

# Note that this plot does not require date-time data. Therefore, the conversion of the Date,Time columns
# to Date/Time format is avoided here.

# Open up a png file to write to with 480*480 pixels as the dimension.
png(filename = "Plot1.png",
    width = 480,
    height = 480,
    units = "px")

hist(subdata$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     col = "red",
     main = "Global Active Power")

dev.off()