# clear memory
rm(list=ls())


#-------------------
# load data file
#-------------------

## setup data file name
datafile = "household_power_consumption.txt"

## find the date range from 2007-02-01 to 2007-02-02
g1 <- grepl('^1/2/2007|^2/2/2007',readLines(datafile))
startline <- min(which(g1==TRUE))
endline <- max(which(g1==TRUE))

# input data from the selected date range
## read table head
hd <- read.table(datafile, nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)

## read data
pwrcons <- read.table(datafile, header=FALSE, sep=";",
                      na.strings="?", stringsAsFactors=FALSE,
                      skip = startline-1,
                      nrows = endline-startline+1)

## assign header to table data
colnames(pwrcons) <- unlist(hd)

## combine date and time
t1 <-strptime(paste(pwrcons$Date,pwrcons$Time),"%d/%m/%Y %H:%M:%S")

#-------------------
# plot data file
#-------------------

## start graphic device
png(filename = "plot3.png",
    width = 480, height = 480, 
    units = "px", pointsize = 12, bg = "white")

## plot
plot(t1,pwrcons$Sub_metering_1,
     col="black",type="l",
     ylab="Energy sub metering",xlab="")

lines(t1,pwrcons$Sub_metering_2,col="red",type="l")

lines(t1,pwrcons$Sub_metering_3,col="blue",type="l")

legend("topright", c("Sub_metering_1", 
                     "Sub_metering_2",
                     "Sub_metering_3"), 
       col = c("black","red","blue"),
       lty=c(1,1,1)
       )

## close the graphic device
dev.off()

