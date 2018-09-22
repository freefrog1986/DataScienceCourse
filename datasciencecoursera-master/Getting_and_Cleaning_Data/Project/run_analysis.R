## Load (or install and load) needed packages 
if (!require("reshape2")) { install.packages("reshape2")}
library("reshape2")

## Download dataset
folder <- "data"
filename <- paste0(folder, "/dataset", format(Sys.time(), "_%m%d%Y"), ".zip")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists(folder)) {dir.create(folder)}
download.file(fileUrl, destfile = filename)
unzip(filename,exdir = paste0("./",folder, "/", format(Sys.time(), "_%m%d%Y")))
file.remove(filename)

## folder with data: dataFolder[3]
dataFolder <- as.character(list.dirs(paste0("./",folder), recursive=TRUE))

## Read data
activityLabels <- read.table( paste0(dataFolder[3], "/activity_labels.txt"))
features <- read.table( paste0( dataFolder[3], "/features.txt"))
subjectTrain <- read.table( paste0(dataFolder[3], "/train/subject_train.txt"))
subjectTest <- read.table( paste0(dataFolder[3], "/test/subject_test.txt"))
trainX <- read.table( paste0( dataFolder[3], "/train/X_train.txt"))
testX <- read.table( paste0( dataFolder[3], "/test/X_test.txt"))
trainY <- read.table( paste0( dataFolder[3], "/train/y_train.txt"))
testY <- read.table( paste0( dataFolder[3], "/test/y_test.txt"))

##Merge data
subject <- rbind(subjectTest, subjectTrain)
x <- rbind(testX, trainX)
y <- rbind(testY, trainY)

## name columns
colnames(subject) <- "subject"
colnames(x) <- features[,2]
colnames(y) <- "activity"

## Get columns with mean and std
meanStd <- grepl("mean|std",colnames(x))

## Merge in one set
allData <- cbind(subject,x[ ,meanStd],y)

## Name activities
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

## new tidy set
newdata <- melt(allData, id = c("subject", "activity"))
meandata <- dcast(newdata, subject + activity ~ variable, mean)
write.table(meandata, "./new_tidy_set.txt", row.names = FALSE, quote = FALSE)




