
# Loops are used to automate a repetitive task, have a concise code and/or avoid errors.

# There are basically two types of loops: for and while loops. The differ in the
# direction of the iterations. For example, the former goes from one to the next
# iteration until all iterations are finished (and no errors happen). While loops
# run until a specific point is reached, and the number of iterations are clearly
# defined from the beginning, such as 1:10.

## Documentation
help(Control)

## rationale
# while loop: while a condition is true, the action keeps running
# while (condition) {action}

# for loop: for a given iteration (value in a list of values), an action takes place
# for (variable in vector) {action}

## example 1
for (i in LETTERS) {
  if (i %in% c("A", "D", "F")) {
    print(paste(i,"present in sequence"))
  } else {
    print(paste("Ops! a stranger was found:", i))
  }
}


## example 2
i <- 0
while (i < 10) {
  print(i)
  i <- i + 1
}


## example 3 (using try)
input <- c(1,10,-7,-2/5,0,"char",100,pi)
# has problems
for (val in input) {
  paste0('Log of ', val, 'is ', log10(val))
}
# shows more in detail where the problem lies
for (val in input) {
  val <- as.numeric(val)
  try(print(paste0('Log of ', val, ' is ', log10(val))))
}
options()


## example 4 (using tryCatch)
input <- c(1,10,-7,-2/5,0,"char",100,pi)
for (val in input) {
  val <- as.numeric(val)
  result <- tryCatch(log10(val), 
                     warning = function(w) { print("Negative argument supplied. Negating."); log10(-val) }, 
                     error = function(e) { print("Not a number!"); NaN }
                     )
  print(paste0("Log of ", val, " is ", result))
}


## example 5 (using warning messages)
f <- function(x) {
  if (x < 0) {
    simpleWarning("Value less than 0. Taking abs(x)")
  }
}
lapply(c(1,2,-20,-3,5), f)
