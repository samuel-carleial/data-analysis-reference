rm(list=ls())

# Available functions -----------------------------------------------------

sample() # random samples and permutation
runif()  # uniform distribution

# A simple randomization example ------------------------------------------

set.seed(3256) # subjective number

## Define treatment labels:
## Example: “portion” and “control” are two treatments
treatments <- c("portion", "control")

## Define the sample size:
sample_size <- 150

## Randomization step: randomize the treatment levels with the sample size nr.
sampling <- sample(x = treatments, size = sample_size, 
                   replace = TRUE, prob = c(.5,.5))

## Display the sampling
plot(as.factor(sampling))

## Tabulate the numbers assigned to each treatment.
table(sampling)

# A block randomization example -------------------------------------------
# Adapted from: https://www.r-bloggers.com/example-2014-2-block-randomization/

set.seed(4532)

## Define the experimental design:
## NOTE: blocks are complete, so they must be a multiple of blocksize
blocksize  <-  6
sample_size  <-  6*5 

blocks  <-  rep(1:ceiling(sample_size/blocksize), each = blocksize)

index <- seq_along(blocks)

assignment <- data.frame(index,
                         blocks,
                         randomization = runif(index))

assignment <- assignment[order(assignment$blocks, assignment$rand), ]
assignment$arm <- rep(c("arm1", "arm2"), times = length(blocks)/2)
assignment <- assignment[order(assignment$index), ]
assignment

