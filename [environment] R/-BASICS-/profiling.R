
# ref: https://github.com/jennybc/raukr
# Profiling is the process of identifying memory and time bottlenecks

# packages and functions
library(profr)
profr::ggplot.profr()
library(profvis)
Rprof()
proc.time()
system.time()

# user time     -- CPU time charged for the execution of user instructions of the calling process
# system time   -- CPU time charged for execution by the system on behalf of the calling process
# elapsed time  -- total CPU time elapsed for the currently running R process

# example: calculate time spent with one task
# how much real and CPU time (in seconds) the currently running R process has already taken.
pt1 <- proc.time()
tmp <- runif(n =  10e5)
pt2 <- proc.time()
pt2 - pt1

# example: calculate time spent with one task
# CPU (and other) times that expr used.
system.time(runif(n = 10e5))
system.time(rnorm(n = 10e6))


# example using system.time(); not so accurate
fun_fill_loop1 <- function(n = 10e6, f) {
  result <- NULL
  for (i in 1:n) {
    result <- c(result, eval(call(f, 1)))
  }
  return(result)
}

fun_fill_loop2 <- function(n = 10e6, f) {
  result <- vector(length = n)
  for (i in 1:n) {
    result[i] <- eval(call(f, 1))
  }
  return(result)
}

fun_fill_vec1 <- function(n = 10e6, f) {
  result <- NULL
  result <- eval(call(f, n))
  return(result)
}

fun_fill_vec2 <- function(n = 10e6, f) {
  result <- vector(length = n)
  result <- eval(call(f, n))
  return(result)
}

system.time(fun_fill_loop1(n = 10e4, "runif")) # Loop 1
system.time(fun_fill_loop2(n = 10e4, "runif")) # Loop 2
system.time(fun_fill_vec1(n = 10e4, "runif"))  # Vectorized 1
system.time(fun_fill_vec2(n = 10e4, "runif"))  # Vectorized 2
