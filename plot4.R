## plot 4

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

## graphics location on the sheet and graphics sizes
par (mfcol=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
## top left corner graphic
with (HPC2, plot(Date_Time, Global_active_power, 
                 type="line", 
                 xlab="", 
                 ylab="Global Active Power"))
## bottom left corner graphic
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
          lty=c (1,1,1),
          bty="n")})
## top right corner graphic
with (HPC2, plot(Date_Time, Voltage, 
                 type="line", 
                 xlab="datetime", 
                 ylab="Voltage"))
## bottom right corner graphic
with (HPC2, plot(Date_Time, Global_reactive_power, 
                 type="line", 
                 xlab="datetime", 
                 ylab="Global_reactive_power"))

## copying graphics to the png file
dev.copy (png, file="plot4.png") 
dev.off ()
