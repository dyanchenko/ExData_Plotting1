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

###-- writing the Plot 1 (histogram) into a PNG file
#displaying a histogram (Plot1) to ensure it is correct as in the task
with(work_data, hist(work_data$Global_active_power, main = "Global Active Power", xlab="Global Active Power (kilowatts)", col="red"))

#copying the histogram from screen device to PNG
dev.copy(png, file = "./Plot1.png") 

#closing the PNG device
dev.off() 
