#
# RANDOM NUMBER GENERATOR
#
# Author: Samuel Carleial
# Date: May 2018
#
# Define the elements
# example: list of houses, list of numbers or sequence (as below)
population <- 1:500
#
# Define the amount of samples to obtain
# example: 100
sample_nr <- 100
#
# Generate a random sample from the population
random_sample <- round(runif(sample_nr, min = 0, max = length(population) + 1))
random_sample
#
# Save randomized sample as a text file in the working directory
dput(random_sample, file="randomized_sample.txt")
#
# Where did I save it?
getwd()