temp = tempfile()
download.file(url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',destfile = temp)
data = read.table(unz(temp,"household_power_consumption.txt"),sep = ';',header = T)
unlink(temp)
#We will only be using data from the dates 2007-02-01 and 2007-02-02.
pow2days = subset(x = data,subset = data$Date %in% c("1/2/2007","2/2/2007"))
pow2days = pow2days[order(pow2days$Date,pow2days$Time),]
pow2days$Date = as.Date(pow2days$Date,format = "%d/%m/%Y")
#pow2days$Time = strptime(pow2days$Time,format = "%H:%M:%S")

#Generate the plot
png(filename = 'plot4.png',width = 480,height = 480,units = 'px')
par(mfcol=c(2,2))

##############
with(data = pow2days,
     plot(as.numeric(Global_active_power),
          ylim = c(0,6000),type = 'n',
          ylab = "Global Active Power (kilowatts)",
          xlab = "",
          xaxt = 'n'
          
     )
)
lines(as.numeric(pow2days$Global_active_power))
axis(side = 1,at = c(0,(nrow(pow2days)/2),nrow(pow2days)),labels= c('Thu','Fri','Sat'))
##################
with(data = pow2days,
     plot(as.numeric(Sub_metering_1),
          ylim = c(0,100),type = 'n',
          ylab = "Energy sub-metering",
          xlab = "",
          xaxt = 'n'
          
     )
)
lines(as.numeric(pow2days$Sub_metering_1),col = "black")
lines(as.numeric(pow2days$Sub_metering_2),col = "red")
lines(as.numeric(pow2days$Sub_metering_3),col = "blue")
axis(side = 1,at = c(0,(nrow(pow2days)/2),nrow(pow2days)),labels= c('Thu','Fri','Sat'))
legend(x = 'topright',
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1),
       col = c("black", "red", "blue")
)
########################

with(data = pow2days,
     plot(as.numeric(Voltage),
          ylim = c(0,2500),type = 'n',
          ylab = "Voltage",
          xlab = "datetime",
          xaxt = 'n'
          
     )
)
lines(as.numeric(pow2days$Voltage))
axis(side = 1,at = c(0,(nrow(pow2days)/2),nrow(pow2days)),labels= c('Thu','Fri','Sat'))
########################

with(data = pow2days,
     plot(as.numeric(Global_reactive_power),
          ylim = c(0,250),type = 'n',
          ylab = "Global Reactive Power (kilowatts)",
          xlab = "datetime",
          xaxt = 'n'
          
     )
)
lines(as.numeric(pow2days$Global_reactive_power))
axis(side = 1,at = c(0,(nrow(pow2days)/2),nrow(pow2days)),labels= c('Thu','Fri','Sat'))
######################
dev.off()