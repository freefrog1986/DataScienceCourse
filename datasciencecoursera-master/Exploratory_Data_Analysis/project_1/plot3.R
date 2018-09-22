# load data
source("get_data.R")

if(!exists("hpc")) 
        hpc <- get_data()

# open PNG device
png("plot3.png", width=480, height=480, units="px")

# draw graph
plot(hpc$Time, hpc$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering")

lines(hpc$Time, hpc$Sub_metering_2, col="red")
lines(hpc$Time, hpc$Sub_metering_3, col="blue")

legend("topright",
       col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1)


# close device to save file
dev.off()
