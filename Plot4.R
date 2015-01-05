# ----------------------------------------------------------
#  Exploratory Data Analysis - D. Yanchenko, 05.01.2015
# ----------------------------------------------------------

# setting time locale to English
Sys.setlocale("LC_TIME", "English")

#setting the URL link
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#donwloading the file to the working directory

if(!file.exists("household_power_consumption.txt")){
        download.file(url, destfile="household_power_consumption.zip")
        unzip("household_power_consumption.zip")
}

#reading the file into memory
data <- read.table("household_power_consumption.txt", sep=';', dec=".", na.strings="?",header=TRUE, colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

#transforming Date from Factor type to Date type
data$Date <- as.Date(data$Date, format="%d/%m/%Y") #tranforming the data type for Data column

#selecting only data for 2007-02-01 and 2007-02-02 days
work_data <- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"),]

#merging data and time
work_data$Date <- paste(work_data$Date, work_data$Time)
work_data$Date <- strptime(work_data$Date, "%Y-%m-%d %H:%M:%S")

###-- writing the Plot 1 (histogram) into a PNG file
#displaying a histogram (Plot1) to ensure it is correct as in the task
png("./Plot4.png")

#splitting the device into 4 zones
par(mfcol = c(2,2))

#top-left plot
with(work_data, plot(work_data$Date,work_data$Global_active_power, ylab = "Global Active Power", xlab="", type="l"))

#bottom-left plot
with(work_data, plot(work_data$Date,work_data$Sub_metering_1, ylab = "Energy sub metering", xlab="", type="l", col="black"))
with(work_data, points(work_data$Date,work_data$Sub_metering_2, type="l", col="red"))
with(work_data, points(work_data$Date,work_data$Sub_metering_3, type="l", col="blue"))
legend("topright", bty="n", lty=1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), text.width = NULL, text.font = 1)

#top-right plot
with(work_data, plot(work_data$Date,work_data$Voltage, ylab = "Voltage", xlab="datetime", type="l"))

#bottom-right plot
with(work_data, plot(work_data$Date,work_data$Global_reactive_power, ylab = "Global_reactive_power", xlab="datetime", type="l"))

#closing the PNG device
dev.off()
