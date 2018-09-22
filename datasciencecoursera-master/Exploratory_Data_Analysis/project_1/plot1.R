# load data
source("get_data.R")

if(!exists("hpc")) 
        hpc <- get_data()

# open PNG device
png("plot1.png", width=480, height=480, units="px")

# draw graph
hist(hpc$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     col="red")

# close device to save file
dev.off()
