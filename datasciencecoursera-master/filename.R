folder <- ""            # data/ or other folder
name <- ""              #file name
date <- format(Sys.time(), "_%m%d%Y_(%H_%M)") #date and time
format <- ""            # .csv,
filename <- paste0(folder, name, date, format)