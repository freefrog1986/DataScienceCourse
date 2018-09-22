corr <- function(directory,  threshold = 0) {
        files_full <- list.files(directory, full.names = TRUE) 
        dataset <- vector(mode = "numeric", length = 0) 
        
        for (i in 1:length(files_full)) {
               
                temp_i <- read.csv(files_full[i])
                
                csum <- sum((!is.na(temp_i$sulfate)) & (!is.na(temp_i$nitrate)))
                
                if (csum > threshold) {
                        tmp <- temp_i[which(!is.na(temp_i$sulfate)), ]
                        subtmp_i <- tmp[which(!is.na(tmp$nitrate)), ]
                        dataset <- c(dataset, cor(subtmp_i$sulfate, subtmp_i$nitrate))
                }
        }
        
        dataset
}