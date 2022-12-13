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

# 3. Open graphics device (png file) to send plot to:
png(filename = "plot2.png", width = 480, height = 480)

# 4. Create plot:
plot(hpc$DateTime, hpc$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
# Obs.: as the day of the week is locale specific and the plots were generated
# in a system where locale was set to Brazilian Portuguese, the labels for the
# days of the week are shown in Portuguese rather than in English.

# 5. Close graphics device:
dev.off()
