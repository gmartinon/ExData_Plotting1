library(lubridate)
library(dplyr)

# read only the first lines of the data set
df <- read.csv("household_power_consumption.txt",
               sep = ";", na.strings = "?", nrows = 70000)

# select only the dates between February, 1st and February 2nd, 2007
df <- df %>% mutate(Date = dmy(Date))
df <- df %>% filter(Date %in% ymd("2007-02-01"):ymd("2007-02-02"))

# plot the histogram
png("plot1.png")
hist(df$Global_active_power, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
