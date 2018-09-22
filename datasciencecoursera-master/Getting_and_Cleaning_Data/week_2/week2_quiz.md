
# Week 2 Quiz

### Question 1
Register an application with the Github API here https://github.com/settings/applications. Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. What time was it created?
This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run the code in the base R package and not R studio.

```
library(httr)
library(jsonlite)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "b958af61532cb2c273dc",
                   secret = "4651e41222124de0114f564e8e1b837ce69dae86")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
output <- content(req)
jsondata <- fromJSON(toJSON(output))
subset(jsondata, name=="datasharing", select= c(created.at))
```

> 2013-11-07T13:25:07Z	


### Question 2
The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL.
Download the American Community Survey data and load it into an R object called
```acs```
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?

```

```
> sqldf("select pwgtp1 from acs where AGEP < 50")


### Question 3
Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)

> sqldf("select distinct AGEP from acs") - in SQL distinct is equivalent to unique	


### Question 4
How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
http://biostat.jhsph.edu/~jleek/contact.html

(Hint: the nchar() function in R may be helpful)

```
connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(connection)
close(connection)
c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))
```
> 45 31  7 25


### Question 5
Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for

(Hint this is a fixed width file format)

```
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4)
fixed <- read.fwf(url, widths, header = FALSE, skip = 4)
sum(fixed[, 4])
```
> 32426.7
