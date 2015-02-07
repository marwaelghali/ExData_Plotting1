
# function for reading and filtering data from file
readData <- function(filename)  {
  library(lubridate)
  
  # read in data, assuming file is in current working directory
  inData <- read.csv(filename, sep=";", stringsAsFactors=F)
  
  # filter by requested date range
  inData$Date <- dmy(inData$Date)
  inData <- inData[inData$Date >= dmy('1/2/2007') & inData$Date <= dmy('2/2/2007'),]
  
  inData
}

# get required data
data <- readData("household_power_consumption.txt")

# convert 'Global Active Power' column to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

# open png file to draw plot to
png(filename="plot1.png", width=480, height=480)

# histogram of Global Active Power
hist(data$Global_active_power, 
     xlim=c(0,6),
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col="red")

# close png device
dev.off()

