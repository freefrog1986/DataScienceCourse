pollutantmean <- function(directory, pollutant, id = 1:332) {
        files_full <- list.files(directory, full.names = TRUE) 
        dataset <- data.frame()                                 #empty data frame for results storing
        
        for (i in id) { 
                                                                #add results from new csv file to frame
                dataset <- rbind(dataset, read.csv(files_full[i])) 
        }
        
        mean(dataset[, pollutant], na.rm = TRUE)                #na.rm - exclude NA & NaN
}