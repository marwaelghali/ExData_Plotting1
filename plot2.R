
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

# convert 'Global Active Power' column to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

# construct combined column of date/time
data$DateTime <- ymd_hms(paste(data$Date, data$Time, sep=" "))

# open png file to draw plot to
png(filename="plot2.png", width=480, height=480)

# line chart of Global Active Power vs Time
plot(data$DateTime, data$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

# close png device
dev.off()
