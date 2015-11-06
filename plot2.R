## Exploratory Data Analysis Course Project 1
## ExData_Plotting1
## Travis Hill

## 
## Data Read-In Code, not specific to a plot. Will be featured
## in plot1.R to plot4.R
##

##Determine specific lines to read in from data to maximize speed.

firstDateTime <- strptime("2006-12-16 17:24:00", "%Y-%m-%d %H:%M:%S") ## Found in first line of datafile
startDateTime <- strptime("2007-02-01 00:01:00", "%Y-%m-%d %H:%M:%S") ## Specified in assignment
skipLines <- as.numeric(startDateTime - firstDateTime) * 1440 ##Determine lines to skip before reading given one line per minute
nLines <- 2880 ##Number of lines given one line per minute in 48 hours

##Obtain the remote file and store zip as a temporary file, unzip, and read unzipped data into dataframe

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

DF <- read.csv(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", skip = skipLines, nrows = nLines)

unlink(temp) ##Remove temp file

##
##Plot 2-Specific Code:
##

##Convert Date and Time columns into a single datetime variable
datetime <- strptime(paste(DF[,1], DF[,2], sep=" "), "%d/%m/%Y %H:%M:%S") 

#Plot datetime against Global Active Power, with proper x/y labels and titles
with(DF, plot(datetime, DF[,3], type="s", xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.copy(png, file = "plot2.png", width = 480, height = 480) ##initialize a PNG, copy screen device results to PNG
dev.off() ##Close PNG Device
