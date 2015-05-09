## read the data and subset it if the required data does not exist in the global environment
## otherwise go to the script for creating png. (Avoid unnecessary overwriting the data with same contents)

if(!exists("data3")){
  library(sqldf)
  file = "household_power_consumption.txt"
  data = read.csv.sql(file, sql = "select * from file where Date in ('2/2/2007','1/2/2007')", header=TRUE, sep=";")
  datetime = strptime(paste(data$Date,data$Time,sep=" "),format= "%d/%m/%Y %H:%M:%S")
  data2 = cbind(data,datetime)
  data3 <<- select(data2,datetime,Global_active_power:Sub_metering_3)
} 

## create graph and save it in png file

png(file="Plot 1.png", width=480,height=480)
with(data3, hist(Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col="red"))
dev.off()
