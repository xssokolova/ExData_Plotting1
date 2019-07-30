## plot 3

##setting working directory
setwd("~/exdata_data_household_power_consumption")
## reading file
HPC <- read.table("household_power_consumption.txt", 
                  header=TRUE, 
                  sep=";", 
                  na.strings = "?", 
                  stringsAsFactors = FALSE, 
                  colClasses = c("character","character", rep("numeric",7)))
## loading dplyr package
library(dplyr)
## cleaning dataset: filtering by Date, formatting date and time
HPC2 <- HPC %>% 
  filter (Date=="1/2/2007"| Date=="2/2/2007") %>% 
  mutate (Date=as.Date(Date, format = "%d/%m/%Y"), Date_Time=as.POSIXct(paste(Date, Time)))
Sys.setlocale("LC_TIME", "English")

##creating graphic
with (HPC2,{
  plot(Date_Time, Sub_metering_1,
       "n",
       xlab="",
       ylab="Energy sub metering")
  points (Date_Time, Sub_metering_1, col="black", type="line")
  points (Date_Time, Sub_metering_2, col="red", type="line")
  points (Date_Time, Sub_metering_3, col="blue", type="line")
  legend ("topright", 
          legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
          col= c("black", "red", "blue"),
          lty=c (1,1,1))})

## copying graphic to the png file
dev.copy (png, file="plot3.png") 
dev.off ()