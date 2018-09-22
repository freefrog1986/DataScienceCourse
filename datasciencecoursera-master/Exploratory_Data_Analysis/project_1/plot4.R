source("get_data.R")

if(!exists("hpc")) 
        hpc <- get_data()
        
# open PNG device
        png("plot4.png", width=480, height=480, units="px")
        par(mfrow=c(2,2))
        
 # draw graph 1
        plot(hpc$Time, hpc$Global_active_power, type="l", xlab="", ylab="Global Active Power")
        
# draw graph 2
        plot(hpc$Time, hpc$Voltage, type="l", xlab="datetime", ylab="Voltage")
        
# draw graph 3
        plot(hpc$Time, hpc$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
        lines(hpc$Time, hpc$Sub_metering_2, col="red")
        lines(hpc$Time, hpc$Sub_metering_3, col="blue")
        legend("topright",
               col=c("black", "red", "blue"),
               c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty=1,
               box.lwd=0)
        
# draw graph 4
        plot(hpc$Time, hpc$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
        
# close device to save file
        dev.off()
