##If dir powerdata not exist, I create it
if (!file.exists('powerdata')) 
  {
  dir.create('powerdata')
}

##Load the libraries that I will use
library(data.table)
library(dplyr)
library(lubridate)


##Download file
file.url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

download.file(file.url,destfile='powerdata/power_consumption.zip')

##Uncompress zip in dir
unzip('powerdata/power_consumption.zip',exdir='powerdata',overwrite=TRUE)

##Read the file, I indicate na are ?
powerall<-read.table('powerdata/household_power_consumption.txt',header=TRUE,sep=';',na.strings='?') 

##Select the data of the days 1 and 2 Febrery
powerall<-powerall[powerall$Date=='1/2/2007' | powerall$Date=='2/2/2007',]

##Create a new var with the columns Date and Time
powerall$DateTime<-dmy(powerall$Date)+hms(powerall$Time)

##Change the lenguage of time a Englih for the shows the days in this lenguage
Sys.setlocale("LC_TIME", "English")

##If dir figure not exist,I create it.Save the png file in this dir
if (!file.exists('figure')) 
  {   
  dir.create('figure')
  }

##Create the plot 1
hist(powerall$Global_active_power,col="red",xlab="Global Active Power(kilowatts)",main="Global Active Power")

##Save the plot 1 in png file as plot1.png
dev.copy(png,file="figure/plot1.png",width = 480, height = 480)
##Close the conect
dev.off()

