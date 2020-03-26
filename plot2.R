# read in data
dataset <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", as.is=TRUE)

#format date
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")

# subset for correct two days
datasetfiltered <- subset(dataset, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

#create date-time column
datasetfiltered$datetime <- as.POSIXct(paste(datasetfiltered$Date, datasetfiltered$Time), format="%Y-%m-%d %H:%M:%S")


# create png device
png("plot2.png", width=480, height=480, units="px", bg="transparent")

# create plot
with (datasetfiltered, {
    plot(datetime, Global_active_power, type="n", ylab="Global Average Power (kilowatts)", xlab="")
    
    # add lines
    lines(datetime,Global_active_power)
})

# turn the device off to ensure writing to png complete
dev.off()