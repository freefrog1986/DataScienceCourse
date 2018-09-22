# load data
source("get_data.R")

if(!exists("hpc")) 
        hpc <- get_data()

# open PNG device
png("plot2.png", width=480, height=480, units="px")

# draw graph
plot(hpc$Time, hpc$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

# close device to save file
dev.off()
