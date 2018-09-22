> library(datasets)
> data(iris)
> ?iris
> summary(iris)

#1
#In this dataset, what is the mean of 'Sepal.Length' for the species virginica?
#Please round your answer to the nearest whole number.
round(tapply(iris$Sepal.Length, iris$Species,mean))

#2
#what R code returns a vector of the means of the variables 'Sepal.Length', 
#'Sepal.Width', 'Petal.Length', and 'Petal.Width'?
apply(iris[, 1:4], 2, mean)


#New dataset
library(datasets)
data(mtcars)

#3
#How can one calculate the average miles per gallon (mpg) by number 
#of cylinders in the car (cyl)? Select all that apply.
sapply(split(mtcars$mpg, mtcars$cyl), mean)
with(mtcars, tapply(mpg, cyl, mean))
tapply(mtcars$mpg, mtcars$cyl, mean)

#4
#what is the absolute difference between the average horsepower of
#4-cylinder cars and the average horsepower of 8-cylinder cars?
cil <- tapply(mtcars$hp, mtcars$cyl, mean)
round(abs(cil[1]-cil[3]))

#5
#If you run
# ~~~debug(ls)
#what happens when you next call the 'ls' function?

Execution of 'ls' will suspend at the beginning of the function and you will be in the browser.
