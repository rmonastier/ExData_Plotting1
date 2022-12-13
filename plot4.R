# 1. Download zip file to the project folder and read the local file to a dataframe:
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
local_file <- "exdata_data_household_power_consumption.zip"
download.file(url = url, destfile = local_file)
hpc <- read.csv2(unz(local_file, filename = "household_power_consumption.txt"),
                 na.strings = "?",
                 dec = ".")

# 2. Filter dates and create new column with both Date AND Time in POSIXlt:
hpc <- hpc[hpc$Date %in% c("1/2/2007","2/2/2007"),]
DateTime <- paste(hpc$Date, hpc$Time)
DateTime <- strptime(DateTime, format = "%d/%m/%Y %H:%M:%S")
hpc <- cbind(hpc, DateTime)

# 3. Open graphics device (png file) to send plot to and set graph parameters:
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

# 4. Create plots:
plot(hpc$DateTime, hpc$Global_active_power, type = "l",
     ylab = "Global Active Power",
     xlab = "")

plot(hpc$DateTime,hpc$Voltage, type = "l",
     ylab = "Voltage",
     xlab = "datetime")

plot(hpc$DateTime, hpc$Sub_metering_1, type = "l",
     col = "black",
     ylab = "Energy sub metering",
     xlab = "")
lines(hpc$DateTime, hpc$Sub_metering_2,
      col = "red")
lines(hpc$DateTime, hpc$Sub_metering_3,
      col = "blue")
legend("topright", lty = 1,
       col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       bty = "n")

plot(hpc$DateTime, hpc$Global_reactive_power, type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime")

# Obs.: as the day of the week is locale specific and the plots were generated
# in a system where locale was set to Brazilian Portuguese, the labels for the
# days of the week are shown in Portuguese rather than in English.

# 5. Close graphics device:
dev.off()
