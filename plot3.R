# read in data
dataset <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", as.is=TRUE)

#format date
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")

# subset for correct two days
datasetfiltered <- subset(dataset, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

#create date-time column
datasetfiltered$datetime <- as.POSIXct(paste(datasetfiltered$Date, datasetfiltered$Time), format="%Y-%m-%d %H:%M:%S")

# create png device
png("plot3.png", width=480, height=480, units="px", bg="transparent")

# create plot
with (datasetfiltered, {
    plot(datetime, Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
    
    # add three lines
    lines(datetime, Sub_metering_1, col="black")
    lines(datetime, Sub_metering_2, col="red")
    lines(datetime, Sub_metering_3, col="blue")
})

# add legend
legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red","blue"), lwd=1, lty=c(1,1,1), merge=FALSE, xjust=2, yjust=0)

# turn off device to ensure write completes
dev.off()