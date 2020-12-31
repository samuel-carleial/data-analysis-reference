
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
