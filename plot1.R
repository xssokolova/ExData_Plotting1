## plot 1

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
hist (HPC2$Global_active_power, 
      col="red", 
      main = "Global Active Power",  
      xlab = "Global active power (kilowatts)")

## copying graphic to the png file
dev.copy (png, file="plot1.png") 
dev.off ()