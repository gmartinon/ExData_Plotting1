library(lubridate)
library(dplyr)

# read only the first lines of the data set
df <- read.csv("household_power_consumption.txt",
               sep = ";", na.strings = "?", nrows = 70000)

# select only the dates between February, 1st and February 2nd, 2007
df <- df %>% mutate(Date = dmy(Date))
df <- df %>% filter(Date %in% ymd("2007-02-01"):ymd("2007-02-02"))

# create datetime object
df <- df %>% mutate(Time = hms(Time))
datetime <- df$Date + df$Time

# set the locale to english for plots ticks (otherwise it is in french)
Sys.setlocale(category = "LC_ALL", locale = "C")

# plot the graph
png("plot4.png")
par(mfrow = c(2,2))

plot(datetime, df$Global_active_power,
     ylab = "Global Active Power",
     type = "l")

plot(datetime, df$Voltage,
     ylab = "Voltage",
     type = "l")

plot(datetime, df$Sub_metering_1,
     ylab = "Energy sub metering",
     type = "l",
     col = "black")
lines(datetime, df$Sub_metering_2, col = "red")
lines(datetime, df$Sub_metering_3, col = "blue")
legend("topright",
       legend = grep("Sub", colnames(df), value = TRUE),
       lty = c(1,1,1),
       bty = "n",
       col = c("black", "red", "blue"))

plot(datetime, df$Global_reactive_power,
     ylab = "Global_reactive_power",
     type = "l")

dev.off()
