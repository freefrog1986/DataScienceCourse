# Week 4 Quiz

### Question 1
The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

and load the data into R. The code book, describing the variable names is here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?
```
folder <- "data"            # data/ or other folder
name <- "housing"              #file name
date <- format(Sys.time(), "_%m%d%Y_(%H_%M)") #date and time
format <- ".csv"            # .csv,
filename <- paste0(folder,"/", name, date, format)

if (!file.exists(folder)) {dir.create(folder)}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(fileUrl, destfile = filename)
housing <- read.csv(filename)
strsplit(names(housing),"wgtp")[123]
```
> ""   "15"	


### Question 2
Load the Gross Domestic Product data for the 190 ranked countries in this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?

Original data sources:

http://data.worldbank.org/data-catalog/GDP-ranking-table
```
folder <- "data"            # data/ or other folder
name <- "countries"              #file name
date <- format(Sys.time(), "_%m%d%Y_(%H_%M)") #date and time
format <- ".csv"            # .csv,
filename <- paste0(folder,"/", name, date, format)

if (!file.exists(folder)) {dir.create(folder)}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

download.file(fileUrl, destfile = filename)
library(data.table)
countries <- data.table(read.csv(filename, skip = 5, nrow = 190, stringsAsFactors = FALSE, header = FALSE))
countries <- countries[, c(1,2,4,5)]
colnames(countries) <- c("CountryCode", "Rank", "Country.Name", "GDP.Value")
countries$GDP.Value <- as.numeric(gsub(",","",countries$GDP.Value))
mean(countries$GDP.Value, na.rm = TRUE)

```
> 377652.4


### Question 3
In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins with "United"? Assume that the variable with the country names in it is named countryNames. How many countries begin with United?
```
length(grep("^United",countries$Country.Name))  #^ marks beggining of string

```
> grep("^United",countryNames), 3	


### Question 4
Load the Gross Domestic Product data for the 190 ranked countries in this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Load the educational data from this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?

Original data sources:

http://data.worldbank.org/data-catalog/GDP-ranking-table

http://data.worldbank.org/data-catalog/ed-stats
```
folder <- "data"            # data/ or other folder
name1 <- "countries2"              #file name
date <- format(Sys.time(), "_%m%d%Y") #date and time
format <- ".csv"            # .csv,
filename <- paste0(folder,"/", name, date, format)
name2 <- "educ"
filename2 <- paste0(folder,"/", name2, date, format)

library(data.table)
if (!file.exists("data")) {dir.create("data")}
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(fileUrl1, destfile = filename)
download.file(fileUrl2, destfile = filename2)


countries <- data.table(read.csv(filename, skip = 5, nrow = 190, stringsAsFactors = FALSE, header = FALSE))
educ <- data.table(read.csv(filename2))

countries <- countries[, c(1,2,4,5)]
colnames(countries) <- c("CountryCode", "Rank", "Country.Name", "GDP.Value")
merged <- merge(countries, educ, by = "CountryCode")

length(grep("Fiscal year end: June 30", merged$Special.Notes, ignore.case = TRUE))

```
> 13


### Question 5
You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get the times the data was sampled.

```
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
```
How many values were collected in 2012? How many values were collected on Mondays in 2012?
```
sum(year(sampleTimes) == 2012)
sum(year(sampleTimes) == 2012 & wday(sampleTimes) == 2) # Monday = 2
```
> 250, 47