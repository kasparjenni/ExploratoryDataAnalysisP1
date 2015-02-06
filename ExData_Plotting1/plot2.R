## Coursera Exploratory Data Analysis Project 1 - plot 2
## Author: Kaspar Jenni
## Date: 2/5/2015

plot2<-function(){
  
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
  
  ##plot 2
  print("Plotting #2")
  par(mfrow=c(1,1), cex=1, cex.main=1)
  with(data_sub, plot(Date_R, 
                      Global_active_power, type="l", main="",
                      xlab="", ylab="Global Active Power(kilowatts)", 
                      lty=1))
  dev.copy(device=png, filename = ".//plot2.png", width = 480, 
           height = 480, units = "px")
  dev.off()
}

