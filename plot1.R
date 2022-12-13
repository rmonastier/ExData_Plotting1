# 1. Download zip file to the project folder and read the local file to a dataframe:
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
local_file <- "exdata_data_household_power_consumption.zip"
download.file(url = url, destfile = local_file)
hpc <- read.csv2(unz(local_file, filename = "household_power_consumption.txt"),
                 na.strings = "?",
                 dec = ".")

# 2. Filters dates and converts date and time from char to date and POSIxlt, respectively:
hpc <- hpc[hpc$Date %in% c("1/2/2007","2/2/2007"),]
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
hpc$Time <- strptime(hpc$Time, format = "%H:%M:%S")

# 3. Open graphics device (png file) to send plot to:
png(filename = "plot1.png", width = 480, height = 480)

# 4. Create plot:
hist(hpc$Global_active_power, 
     col = "red",
     main = "Global Active Power",
     ylab = "Frequency", xlab = "Global Active Power (kilowatts")

# 5. Close graphics device:
dev.off()





