# Simulation of the Central Limit Theorem and Basic Inferential Data Analysis
# Author: Bo Liu

## Overview
## This report consists of two parts, simulation of the Central Limit Theorem
## and Basic Inferential Data Analysis. In the first part, we will investigate
## the exponential distribution in R and compare it with the Central Limit Theorem. 
##

## SIMULATIONS
### Set some parameters before we start the simulations. average_number stands 
### for the number of exponentials. sample_number is the simulations times.
lambda = 0.2
average_number = 40
sample_number = 1000

### sample the distribution of averages of 40 exponentials a thousand times
sample_mean_distribution<-sapply(1:sample_number,
                                 function(i)mean(rexp(average_number,lambda)))
sample_mean_distribution

## Sample Mean versus Theoretical Mean
### get the sample mean
sample_mean<-mean(sample_mean_distribution)

### theoretical mean of the distribution is 1/lambda
theoretical_mean<-1/lambda

### comparison of sample mean and theoretical mean
sample_mean-theoretical_mean

### plot the distribution of average 40 exponentials with sample mean and
### theoretical mean, the blue line indicates the sample mean and red line
### stands for the theoretical mean.
hist(sample_mean_distribution, main="Distribution of average 40 exponentials")
abline(v= sample_mean, col = "blue", lwd = 4)
abline(v= theoretical_mean, col = "red", lwd = 4)

### It is pretty close, so CLT worked in this experiment.

## Sample Variance versus Theoretical Variance
### sample variance
sample_variance<-var(sample_mean_distribution)

### theoretical variance of the distribution is sigma^2/n
theoretical_variance<-((1/lambda)^2)^2/sample_number

### comparison of sample variance and theoretical variance
sample_variance-theoretical_variance

### plot the distribution of average 40 exponentials with sample variance and
### theoretical variance frome the sample mean, the blue line indicates the 
### sample variance and red line stands for the theoretical variance.
hist(sample_mean_distribution, main="Distribution of average 40 exponentials")
abline(v= sample_mean+sample_variance, col = "blue", lwd = 4)
abline(v= sample_mean+theoretical_variance, col = "red", lwd = 4)

### The two values are almost the same, so CLT worked again.

## Distribution
### plot the distribution of a large collection of random exponentials
hist(rexp(1000,lambda), density = 40)

### plot the distribution of a large collection of averages of 40 exponentials
hist(sample_mean_distribution, density = 40)

### The plot shown above indicates that the distribution of 40 exponentials. 
### The shape of the distribution is like a bell curve and symmetric from the
### distrition mean. So it is far more Gaussian than the original distribution! 

Basic Inferential Data Analysis

