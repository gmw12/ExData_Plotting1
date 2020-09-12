library(data.table)
library(dplyr)

# download data from url, unzip file to working directory
df_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(df_url, "df.zip")
unzip("df.zip")

#read data
df <- fread("./data/household_power_consumption.txt", 
            colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
            na.strings = c("?","") )

# subset data for required dates only
df <- subset(df, Date=="1/2/2007" | Date=="2/2/2007")

# convert to datetime format, combine date/time
df$Date <- as.Date(df$Date, format="%d/%m/%Y")
df$date_time = as.POSIXct(paste(df$Date, df$Time, sep=" "), template = "%d/%m/%Y %H:%M:%S", tz = Sys.timezone())



# create 2x2 graphs (4plots) and save to png
png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))

#4 graphs by row: top-left, top-right, bottom-left and bottom right
plot(x=df$date_time, y = df$Global_active_power, type="l", xlab="", ylab="Global active power")

plot(x=df$date_time, y = df$Voltage, type="l", ylab="Voltage", xlab = "datetime")

with(df, 
     { plot(x=date_time, y = Sub_metering_1, type="l", col = "black", xlab="", ylab="Energy sub metering")
         lines(x=date_time, y = Sub_metering_2, type="l", col = "red")
         lines(x=date_time, y = Sub_metering_3, type="l", col = "blue")
         legend("topright", lty = "solid", bty="n", col = c("black", "red", "blue"), 
                legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
     })

plot(x=df$date_time, y = df$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab = "datetime")
dev.off()

