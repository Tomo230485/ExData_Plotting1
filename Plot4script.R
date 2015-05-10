## read the data and subset it if the required data does not exist in the global environment
## otherwise go to the script for creating png. (Avoid unnecessary overwriting the data with same contents)

if(!exists("data3")){
  library(sqldf)
  file = "household_power_consumption.txt"
  data = read.csv.sql(file, sql = "select * from file where Date in ('2/2/2007','1/2/2007')", header=TRUE, sep=";")

  datetime = strptime(paste(data$Date,data$Time,sep=" "),format= "%d/%m/%Y %H:%M:%S")
  data2 = cbind(data,datetime)
  data3 = select(data2,datetime,Global_active_power:Sub_metering_3)
}

## create graph and save it in png file

png(file="Plot4.png", width=480,height=480)
par(mfrow=c(2,2))

with(data3, {
  plot(datetime,Global_active_power, xlab= "", ylab="Global Active Power", type="l")
  
  plot(datetime,Voltage, xlab= "datetime", ylab="Voltage", type="l")
  
  plot(datetime,Sub_metering_1, xlab= "", ylab="Energy sub metering", type="l")
    points(datetime,Sub_metering_2, col="red", type="l")
    points(datetime,Sub_metering_3, col="blue", type="l")
    legend("topright", lty=1, col= c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n",cex=0.9)
  
  plot(datetime,Global_reactive_power, xlab= "datetime", ylab="Global_reactive_power", type="l")
})
dev.off()