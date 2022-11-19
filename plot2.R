library(tidyverse)
library(lubridate)

#check if file exists, and if not, download and unzip
if(file.exists('hpc.zip')) {
  print('file present')
} else {
  download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 'hpc.zip')
  unzip('hpc.zip')
}

#read table into memory
hpc <- read.table('household_power_consumption.txt', sep=';', header=TRUE, na.strings = '?')

#convert date and time to datetime
hpc <- hpc %>%
  mutate(datetime = dmy(Date) + hms(Time))

#filter using dates for all times between the first and the end of the second of Feb 2007
hpc0102 <- hpc %>% 
  filter(datetime %between% c('2007-02-01', '2007-02-03')) %>%
  slice(1:(n() - 1))

#open device and set parameters
png(filename = './plot2.png', width = 480, height = 480, units='px')

#create plot and customize labels
with(hpc0102, plot(datetime, Global_active_power, type='l', xlab='', ylab='Global Active Power (kiloWatts)'))

#close device
dev.off()