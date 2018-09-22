# Week 3
### Question 1
The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
and load the data into R. The code book, describing the variable names is here:
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.
``` which(agricultureLogical) ```

What are the first 3 values that result?
```
if (!file.exists("data")) {dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "data/idaho.csv")
dateDownloaded <- date()
idaho <- read.csv("data/idaho.csv")
agricultureLogical <- with(idaho, AGS == 6 & ACR == 3)
which(agricultureLogical)[1:3]
```
> 125 238 262

### Question 2
Using the jpeg package read in the following picture of your instructor into R https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg

Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)

```
library(jpeg)

if (!file.exists("data")) {dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl, destfile = "data/jeff.jpg", mode = "wb")
dateDownloaded <- date()
jeff <- readJPEG("data/jeff.jpg", native = TRUE)

quantile(jeff, probs = c(0.3, 0.8))

```
> -15259150 -10575416 


### Question 3
Load the Gross Domestic Product data for the 190 ranked countries in this data set: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Load the educational data from this data set: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?

Original data sources:
http://data.worldbank.org/data-catalog/GDP-ranking-table
http://data.worldbank.org/data-catalog/ed-stats

```
library(data.table)
if (!file.exists("data")) {dir.create("data")}
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl1, destfile = "data/countries.csv")
download.file(fileUrl2, destfile = "data/education.csv")
dateDownloaded <- date()

countries <- data.table(read.csv("data/countries.csv", skip = 5, nrow = 190, stringsAsFactors = FALSE, header = FALSE))
educ <- data.table(read.csv("data/education.csv"))

countries <- countries[, c(1,2,4,5)]
colnames(countries) <- c("CountryCode", "Rank", "Country.Name", "GDP.Value")
merged <- merge(countries, educ, by = "CountryCode")
nrow(merged)


merged[,"Rank"] <- as.numeric(merged$Rank)
merged <- arrange(merged, desc(Rank))
merged[13,"Country.Name"]

```
> 189 ,	"St. Kitts and Nevis"


### Question 4
What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?

```
merged %>% group_by(Income.Group) %>% summarize(mean(Rank, na.rm = TRUE))


```
> 32.96667 , 91.91304


### Question 5
Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?

```
library(Hmisc)
merged$Rank.Groups <-  cut2(merged$Rank, g = 5)
table(merged$Income.Group, merged$Rank.Groups)

```
> 5
