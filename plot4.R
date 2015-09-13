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

##Indicate the par= marge in the screen
par(mar=c(4,4,2,2))

##Indicate the par= mfcol for the order of filled the 4 plots in the screen
par(mfcol=c(2,2))

##Create the fisrt plot, show topleft
plot(powerall$DateTime,powerall$Global_active_power,ylab='Global Active Power', xlab='', type='l')

##Create the second plot, show bottomleft
with(powerall,plot(powerall$DateTime,powerall$Sub_metering_1,ylab='Energy sub metering', xlab='', type='l'))
with(subset(powerall,powerall$Sub_metering_1==0),points(powerall$DateTime,powerall$Sub_metering_2,type='l',col="red"))
with(subset(powerall,powerall$Sub_metering_1==0),points(powerall$DateTime,powerall$Sub_metering_3,type='l',col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.6,bty="n")

##Create the third plot, show topright
plot(powerall$DateTime,powerall$Voltage,ylab='Voltage', xlab='datetime', type='l')

##Create the fourth plot, show bottomright
plot(powerall$DateTime,powerall$Global_reactive_power,ylab='Global_reactive_power', xlab='datetime', type='l')

##Copy and save the png file in dir
dev.copy(png,file="figure/plot4.png",width = 480, height = 480)
##Close the connect
dev.off()

