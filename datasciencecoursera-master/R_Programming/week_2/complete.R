complete <- function(directory, id = 1:332) {
        files_full <- list.files(directory, full.names = TRUE) 
        dataset <- data.frame()                                #empty data frame for results storing
        
        for (i in id) { 
        
                temp_i <- read.csv(files_full[i])              #temp data frame  for current file
                nobs <- sum(complete.cases(temp_i))            #complete.cases() - existing func
                dataset <- rbind(dataset, data.frame(i, nobs)) #add results from new file to existing frame
        }
        colnames(dataset) <- c("id", "nobs")                   #assign columns names
        dataset                                                #print result
}