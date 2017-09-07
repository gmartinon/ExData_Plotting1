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
png("plot2.png")
plot(datetime, df$Global_active_power,
     ylab = "Global Active Power (kilowatts)",
     type = "l")
dev.off()
