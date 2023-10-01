if (!"tidyverse" %in% (.packages())){
        library(tidyverse)
}

# Read in data
df <- read.table(file="household_power_consumption.txt", header = TRUE, sep=";")
# Add a new column to store the datetime
df <- df %>% mutate (Date_Time= paste(Date, Time))
# Filter those data on 2007/2/1 and 2007/2/2
df$Date <- dmy(df$Date)
df1 <- df %>% filter (Date ==  ymd("2007-02-01") | Date ==  ymd("2007-02-02") )
df1$Date_Time <- dmy_hms(df1$Date_Time)

#Change characters to numeric
df1$Global_active_power <- as.numeric(df1$Global_active_power)
df1$Voltage <- as.numeric(df1$Voltage)
df1$Global_reactive_power <- as.numeric(df1$Global_reactive_power)
df1$Sub_metering_1 <- as.numeric(df1$Sub_metering_1)
df1$Sub_metering_2 <- as.numeric(df1$Sub_metering_2)
df1$Sub_metering_3 <- as.numeric(df1$Sub_metering_3)

#Change system language to English
local <- Sys.getlocale("LC_TIME")
suppressWarnings(Sys.setlocale("LC_ALL","English"))

# plot
png("plot4.png", width=480, height=480)
par(mfcol=c(2, 2), mar= c(4, 4, 1, 1), oma=c(2,2,2,2))
plot(df1$Date_Time, df1$Global_active_power, type="l", xlab="",
     ylab = "Global Active Power (kilowatts)")

plot(df1$Date_Time, df1$Sub_metering_1, type="l", col="black", xlab="",
     ylab = "Energy sub metering")
lines(df1$Date_Time, df1$Sub_metering_2, type="l", col="red")
lines(df1$Date_Time, df1$Sub_metering_3, type="l", col="blue")
legend("topright", bty = "n", lty=1, col= c("black", "red", "blue"), 
       legend = c("Submetering_1", "Submetering_2", "Submetering_3"),cex = 0.9)

plot(df1$Date_Time, df1$Voltage, type="l", xlab = "datetime", ylab="Voltage")

plot(df1$Date_Time, df1$Global_reactive_power, type="l", 
     xlab = "datetime", ylab="Global_reactive_power")
dev.off()

# Set system language back to local
Sys.setlocale(locale = local)