temp = tempfile()
download.file(url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',destfile = temp)
data = read.table(unz(temp,"household_power_consumption.txt"),sep = ';',header = T)
unlink(temp)
#We will only be using data from the dates 2007-02-01 and 2007-02-02.

pow2days = subset(x = data,subset = data$Date %in% c("1/2/2007","2/2/2007"))
pow2days = pow2days[order(pow2days$Date,pow2days$Time),]
pow2days$Date = as.Date(pow2days$Date,format = "%d/%m/%Y")
#pow2days$Time = strptime(pow2days$Time,format = "%H:%M:%S")

#Generate Second Plot
png(filename = 'plot2.png',width = 480,height = 480,units = 'px')
with(data = pow2days,
     plot(as.numeric(Global_active_power),
          ylim = c(0,4000),type = 'n',
          xlim = c(0,nrow(pow2days)),
          ylab = "Global Active Power (kilowatts)",
          xlab = "datetime",
          xaxt = "n"
          
          
     )
)
lines(as.numeric(pow2days$Global_active_power))
axis(side = 1,at = c(0,(nrow(pow2days)/2),nrow(pow2days)),labels= c('Thu','Fri','Sat'))

dev.off()
