
# Iterate in a loop in order to make a repetitive action. Automate an R action.


## rationale: for (iteration) {action}


## example
for (i in LETTERS) {
  if (i %in% c("A", "D", "F")) {
    print(paste(i,"present in sequence"))
  } else {
    print(paste("Ops! a stranger was found:", i))
  }
}


