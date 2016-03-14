temp = tempfile()
download.file(url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',destfile = temp)
data = read.table(unz(temp,"household_power_consumption.txt"),sep = ';',header = T)
unlink(temp)
#We will only be using data from the dates 2007-02-01 and 2007-02-02.
pow2days = subset(x = data,subset = data$Date %in% c("1/2/2007","2/2/2007"))
pow2days = pow2days[order(pow2days$Date,pow2days$Time),]
pow2days$Date = as.Date(pow2days$Date,format = "%d/%m/%Y")
#pow2days$Time = strptime(pow2days$Time,format = "%H:%M:%S")

#Generate First Plot
png(filename = 'plot1.png',width = 480,height = 480,units = 'px')
with(data = pow2days,
     hist(as.numeric(Global_active_power),breaks = 15,
          col ="red",
          ylim = c(0,1200),xlim = c(0,4000),
          main = "Global Active Power",
          xlab = "Global Active Power (kilowatts)"
     )
)

dev.off()