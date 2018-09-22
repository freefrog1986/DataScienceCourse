## Download dataset
get_data <- function() {
        folder = "data"
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        
        if (!file.exists(folder)) {dir.create(folder)}
        download.file(fileUrl, destfile = paste0(folder, "/household_power_cons.zip"))
        unzip(paste0(folder, "/household_power_cons.zip"), exdir = folder)
        
        #read the data
        hpc <- read.table(paste0(folder,"/household_power_consumption.txt"), 
                           sep = ";", 
                           header = TRUE, 
                           colClasses=c(rep("character", 2), rep("numeric",7)), 
                           na="?")
        
        # I use the same var to save RAM
        hpc <- subset(hpc, Date %in% c("1/2/2007", "2/2/2007"))
        
        #convert to date ant time
        hpc$Time <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")
        hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
        return(hpc)
}
