library(data.table)
library(dplyr)

# data downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# and unzipped into "data" folder in working directory

#read data
df <- fread("./data/household_power_consumption.txt", 
            colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
            na.strings = c("?","") )

# subset data for required dates only
df <- subset(df, Date=="1/2/2007" | Date=="2/2/2007")

# convert to datetime format, combine date/time
df$Date <- as.Date(df$Date, format="%d/%m/%Y")
df$date_time = as.POSIXct(paste(df$Date, df$Time, sep=" "), template = "%d/%m/%Y %H:%M:%S", tz = Sys.timezone())



#create histogram for screen
hist(as.numeric(df$Global_active_power), 
     col="red",
     xlab = "Global Active Power (kilowats)",
     main = "Global Active Power")


#save histogram
png("plot1.png", width = 480, height = 480)
hist(as.numeric(df$Global_active_power), 
     col="red",
     xlab = "Global Active Power (kilowats)",
     main = "Global Active Power")
dev.off()
