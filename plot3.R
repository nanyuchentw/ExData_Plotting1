library(tidyverse)
df <- read.table(file="household_power_consumption.txt", header = TRUE, sep=";")
df <- df %>% mutate (Date_Time= paste(Date, Time))
df$Date <- dmy(df$Date)
df1 <- df %>% filter (Date ==  ymd("2007-02-01") | Date ==  ymd("2007-02-02") )
df1$Date_Time <- dmy_hms(df1$Date_Time)

df1$Sub_metering_1 <- as.numeric(df1$Sub_metering_1)
df1$Sub_metering_2 <- as.numeric(df1$Sub_metering_2)
df1$Sub_metering_3 <- as.numeric(df1$Sub_metering_3)


local <- Sys.getlocale("LC_TIME")
suppressWarnings(Sys.setlocale("LC_ALL","English"))


png("plot3.png", width=480, height=480)
plot(df1$Date_Time, df1$Sub_metering_1, type="l", col="black", xlab="",
     ylab = "Energy sub metering")
lines(df1$Date_Time, df1$Sub_metering_2, type="l", col="red")
lines(df1$Date_Time, df1$Sub_metering_3, type="l", col="blue")
legend("topright", lty = 1, col= c("black", "red", "blue"), 
       legend = c("Submetering_1", "Submetering_2", "Submetering_3"),cex = 1)

dev.off()

Sys.setlocale(locale = local)