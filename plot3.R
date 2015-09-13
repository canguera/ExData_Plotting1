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

##If dir figure not exist,I create it. Save the png file in this dir
if (!file.exists('figure')) 
{   
  dir.create('figure')
}

##Create the plot3.I use "with" and "subset" functions for put the 3 var on y-asis
with(powerall,plot(powerall$DateTime,powerall$Sub_metering_1,ylab='Energy sub metering', xlab='', type='l'))

with(subset(powerall,powerall$Sub_metering_1==0),points(powerall$DateTime,powerall$Sub_metering_2,type='l',col="red"))

with(subset(powerall,powerall$Sub_metering_1==0),points(powerall$DateTime,powerall$Sub_metering_3,type='l',col="blue"))

##Create the legend for 3 var
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


##Copy and save the png file as plot3.png in dir
dev.copy(png,file="figure/plot3.png",width = 480, height = 480)
##Close the conect
dev.off()
