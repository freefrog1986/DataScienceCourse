# Week 1 Quiz

### Question 1
The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
        https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
and load the data into R. The code book, describing the variable names is here:
        https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

How many properties are worth $1,000,000 or more?
```
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, "housing_Idaho.csv")
housing <- read.table("./housing_Idaho.csv", sep = ",", header = TRUE)
sum(housing$VAL == 24) # 24: >=1,000,000
```

> 53


### Question 2
Use the data you loaded from Question 1. Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate?

> Tidy data has one variable per column.


### Question 3
Download the Excel spreadsheet on Natural Gas Aquisition Program here:
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx
Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
```
dat
```
What is the value of:
```
sum(dat$Zip*dat$Ext,na.rm=T)
```
(original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program)

```
fileURL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileURL2, "gas.xlsx")
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("./gas.xlsx", sheetIndex = 1, colIndex = colIndex, rowIndex = rowIndex)
sum(dat$Zip*dat$Ext,na.rm=T)
```
> 36534720


### Question 4
Read the XML data on Baltimore restaurants from here:
 https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml
How many restaurants have zipcode 21231?

```
fileURL3 <- "http://d396qusza40orc.cloudfront.net/getdata/data/restaurants.xml"
library(XML)
data <- xmlTreeParse(fileURL3, useInternalNodes = TRUE)
zipcode <- xpathSApply(rootNode,"//zipcode", xmlValue)
sum(zipcode==21231)
```
> 127


### Question 5
The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
 https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
using the fread() command load the data into an R object
```
DT
```
The following are ways to calculate the average value of the variable
```
pwgtp15
```
broken down by sex. Using the data.table package, which will deliver the fastest user time?

```
start.time <- proc.time()
DT[,mean(pwgtp15),by=SEX]
end.time <- proc.time()
cat("Elapsed; ", end.time[1]-start.time[1], "seconds.\n")

start.time <- proc.time()
tapply(DT$pwgtp15,DT$SEX,mean)
end.time <- proc.time()
cat("Elapsed; ", end.time[1]-start.time[1], "seconds.\n")

start.time <- proc.time()
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
end.time <- proc.time()
cat("Elapsed; ", end.time[1]-start.time[1], "seconds.\n")

start.time <- proc.time()
mean(DT$pwgtp15,by=DT$SEX)
end.time <- proc.time()
cat("Elapsed; ", end.time[1]-start.time[1], "seconds.\n")

start.time <- proc.time()
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
end.time <- proc.time()
cat("Elapsed; ", end.time[1]-start.time[1], "seconds.\n")

start.time <- proc.time()
sapply(split(DT$pwgtp15,DT$SEX),mean)
end.time <- proc.time()
cat("Elapsed; ", end.time[1]-start.time[1], "seconds.\n")
```
> DT[,mean(pwgtp15),by=SEX] 
