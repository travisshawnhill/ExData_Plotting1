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
##Plot 3-Specific Code:
##

##Convert Date and Time columns into a single datetime variable
datetime <- strptime(paste(DF[,1], DF[,2], sep=" "), "%d/%m/%Y %H:%M:%S") 

##This time use the png device off the bat to keep the legend in proportion
png(filename = "plot3.png", width = 480, height = 480)

#Plot datetime against Energy sub metering, initialize plot first with 'type=n'
with(DF, plot(datetime, DF[,7], type="n", xlab = "", ylab = "Energy sub metering"))

points(datetime, DF[,7], col = "black", type = "s") ## Add points for Sub metering 1
points(datetime, DF[,8], col = "red", type = "s") ## Add points for Sub metering 2
points(datetime, DF[,9], col = "blue", type = "s") ## Add points for Sub metering 3

## Generate legend with labels and colors
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col = c("black","blue","red"))

dev.off() ##Close PNG Device
