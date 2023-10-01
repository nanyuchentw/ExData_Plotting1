if (!"tidyverse" %in% (.packages())){
        library(tidyverse)
}

df <- read.table(file="household_power_consumption.txt", header = TRUE, sep=";")
df <- df %>% mutate (Date_Time= paste(Date, Time))
df$Date <- dmy(df$Date)
df1 <- df %>% filter (Date ==  ymd("2007-02-01") | Date ==  ymd("2007-02-02") )
df1$Date_Time <- dmy_hms(df1$Date_Time)

df1$Global_active_power <- as.numeric(df1$Global_active_power)

local <- Sys.getlocale("LC_TIME")
suppressWarnings(Sys.setlocale("LC_ALL","English"))

png("plot2.png", width=480, height=480)
plot(df1$Date_Time, df1$Global_active_power, type="l", xlab="",
     ylab = "Global Active Power (kilowatts)")
dev.off()

Sys.setlocale(locale = local)
