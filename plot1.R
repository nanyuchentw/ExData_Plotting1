if (!"tidyverse" %in% (.packages())){
        library(tidyverse)}

df <- read.table(file="household_power_consumption.txt", header = TRUE, sep=";")
df$Date <- dmy(df$Date)
df1 <- df %>% filter (Date ==  ymd("2007-02-01") | Date ==  ymd("2007-02-02") )

df1$Global_active_power <- as.numeric(df1$Global_active_power)

png("plot1.png", width=480, height=480)
hist(df1$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)", main ="Global Active Power")
dev.off()
