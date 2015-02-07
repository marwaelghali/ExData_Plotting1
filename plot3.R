
# function for reading and filtering data from file
readData <- function(filename)
{
  # read in data, assuming file is in current working directory
  inData <- read.csv(filename, sep=";", stringsAsFactors=F)
  
  # filter by requested date range
  inData$Date <- dmy(inData$Date)
  inData <- inData[inData$Date >= dmy('1/2/2007') & inData$Date <= dmy('2/2/2007'),]
  
  inData
}


library(lubridate)

# read in data
data <- readData("household_power_consumption.txt")

# construct combined column of date/time
data$DateTime <- ymd_hms(paste(data$Date, data$Time, sep=" "))

# open png file to draw plot to
png(filename="plot3.png", width=480, height=480)

# line charts of Energy Sub Metering vs Time
plot(data$DateTime, data$Sub_metering_1,
     type="l",
     col="black",
     xlab="",
     ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_2,
     col="red")
lines(data$DateTime, data$Sub_metering_3,
      col="blue")

# add legend to the chart
legend("topright", 
       names(data)[7:9],
       lty=1,
       col=c("black", "red", "blue"))

# close png device
dev.off()
