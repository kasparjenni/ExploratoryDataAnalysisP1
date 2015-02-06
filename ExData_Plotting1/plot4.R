## Coursera Exploratory Data Analysis Project 1 - plot 4
## Author: Kaspar Jenni
## Date: 2/5/2015

plot4<-function(){
  
  library(dplyr)
  library(lubridate)
  library(graphics)
  
  
  if (!file.exists("data")){dir.create("data")}
  if (!file.exists("data//data_project1.zip")){
    print("Downloading file")
    fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url = fileURL, destfile = "data//data_project1.zip", method = "auto", mode = "wb")
    downloadDate_zip <- date()
  }else{print("File already downloaded")}
  
  
  setwd(".//data")
  if(!file.exists(unzip(zipfile=".//data_project1.zip", list=TRUE)[[1]])){
    print("Unzipping")
    unzip(zipfile=".//data_project1.zip")
  }else{print("File exists - skipping unzipping")}
  
  setwd("../")
  
  data<-read.table(".//data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
  data<-tbl_df(data)
  data<-mutate(data, Date=dmy(Date), Date_R=ymd_hms(paste(Date, Time)))
  
  data_sub<-filter(data,Date==ymd(20070201)| Date == ymd(20070202))
  globalActivePower<-data_sub$Global_active_power
  
  #plot 4
  print("Plotting #4")
  par(mfrow=c(2,2), cex=0.75, cex.lab=1, cex.axis = 1, cex.main=1)
  with(data_sub,{
    #plot4[1,1]
    plot(Date_R, 
         Global_active_power, type="l", main="",
         xlab="", ylab="Global Active Power", 
         lty=1)
    #plot4[1,2]
    plot(Date_R, Voltage, type="l",xlab="datetime", ylab="Voltage")
    #plot4[2,1]
    plot(Date_R, Sub_metering_1, type = "l", col="black", main="",
         xlab="", ylab="Energy sub metering")
    lines(Date_R, Sub_metering_2, type = "l", col="red")
    lines(Date_R, Sub_metering_3, type = "l", col="blue")
    legend("topright", lty=1, col=c("black", "red", "blue"), 
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
    #plot4[2,2]
    plot(Date_R, Global_reactive_power, type="l", xlab="datetime")
  })
  dev.copy(device=png, filename = ".//plot4.png", width = 480, 
           height = 480, units = "px")
  dev.off()
}