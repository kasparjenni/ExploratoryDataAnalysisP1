## Coursera Exploratory Data Analysis Project 1 - plot 1
## Author: Kaspar Jenni
## Date: 2/5/2015

plot1<-function(){
  
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
   
  ##plot 1
  print("Plotting #1")
  par(mfrow=c(1,1), cex=0.75, cex.main=1)
  hist(globalActivePower[!is.na(globalActivePower)], col="red", 
       main="Global Active Power", xlab="Global Active Power (kilowatts)", cex.lab=0.75, cex.axis = 0.75)
  dev.copy(device=png, filename = ".//plot1.png", width = 480, 
           height = 480, units = "px")
  dev.off()
}


