# read in data
dataset <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", as.is=TRUE)

#format date
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")

# subset for correct two days
datasetfiltered <- subset(dataset, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

#create date-time column
datasetfiltered$datetime <- as.POSIXct(paste(datasetfiltered$Date, datasetfiltered$Time), format="%Y-%m-%d %H:%M:%S")


# create png device
png("plot4.png", width=480, height=480, units="px", bg="transparent")


#create plot framework
# four plots in two rows/columns
par(mfrow=c(2,2), mar = c(4,4,2,1))

# create first plot
## plot for upper left
with (datasetfiltered, {
    
    # create plot
    with (datasetfiltered, 
          plot(datetime, Global_active_power, type="n", ylab="Global Average Power", xlab=""))
    
    # add lines
    lines(datetime, Global_active_power)
    
    # create second plot
    ## plot for upper right
    with (datasetfiltered, plot(datetime, Voltage, type="n", ylab="Voltage", xlab="datetime"))
    # add lines to plot
    lines(datetime, Voltage)
    
    # create third plot
    ## Plot for lower left
    with (datasetfiltered, 
          plot(datetime, Sub_metering_1, type="n", ylab="Energy sub metering", xlab=""))
    
    # add lines
    lines(datetime, Sub_metering_1, col="black")
    lines(datetime, Sub_metering_2, col="red")
    lines(datetime, Sub_metering_3, col="blue")
    
    # add legend - but turn off bounding box
    # box.lwd=0 will work fine. 
    # bty='n' is probably better, because it means that legend box type is NONE
    legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red","blue"), lwd=1, lty=c(1,1,1), bty='n', merge=FALSE, xjust=2, yjust=0)
    
    # create fourth plot
    ## plot for lower right
    with (datasetfiltered, 
          plot(datetime, Global_reactive_power, type="n", ylab="Global_reactive_power", xlab="datetime"))
    
    # add lines
    lines(datetime, Global_reactive_power)
    
})
# end plot construction

# turn off device to ensure writing completes
dev.off()