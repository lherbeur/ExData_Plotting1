library(tidyverse)
library(sqldf)
library(lubridate)
library(grid)
library(gridExtra)


path <- 'household_power_consumption.txt'

# x <- object.size(read.csv(path))
# x <- x/2^20 #in MB - 246

# query <- "select * from file"  # where Date between '01/02/2007' and '02/02/2007'
household_data <- read.csv2(path, header = TRUE, stringsAsFactors = FALSE)  #csv2.sql(path, query)
household_data <- as.tibble(household_data)

household_data$Date <- as.Date(household_data$Date, format = "%d/%m/%Y")
household_data$Time <- strptime(household_data$Time, format = "%H:%M:%S")
household_data <- household_data[household_data$Date >= '2007/02/01' &
                                   household_data$Date <= '2007/02/02',]
household_data$Global_active_power <- as.numeric(household_data$Global_active_power)
household_data$Global_reactive_power <- as.numeric(household_data$Global_reactive_power)
household_data$Sub_metering_1 <- as.numeric(household_data$Sub_metering_1)
household_data$Sub_metering_2 <- as.numeric(household_data$Sub_metering_2)
household_data$Sub_metering_3 <- as.numeric(household_data$Sub_metering_3)
household_data$Voltage <- as.numeric(household_data$Voltage)


# plot3
png(filename="C://Users/Lherbeur/Documents/Projects/R/12.EDA 1/plot3.png")

ggplot(data = household_data) + 
  geom_line(aes(x = household_data$Time, y = household_data$Sub_metering_1, colour = 'green')) +
  geom_line(aes(x = household_data$Time, y = household_data$Sub_metering_2, colour = 'red'))+
  geom_line(aes(x = household_data$Time, y = household_data$Sub_metering_3, colour = 'blue')) +
  scale_x_datetime(date_breaks = "1 day") +
  labs( y = 'Submetering', x = 'Day', title ='Plot 3') +
  scale_color_manual(labels = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), values = c("green", "red", "blue")) 

dev.off() 