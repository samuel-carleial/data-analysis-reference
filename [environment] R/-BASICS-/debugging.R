
# ref: https://github.com/jennybc/raukr
# Debugging code is a crucial part of a programmer's life. Lots of time may
# actually be spent in that task during data analysis. There are a couple of
# ways to debug code:

# (1) checking exhaustively with print statements
# print values at checkpoints all the way across the code
# very laborious, and adds "junk" to code

# (2) saving errors
# if errors occur, R may save those to files, which could be
# read into debuggers or evaluated by colleagues
# values of all variables can be checked
options(error = quote(dump.frames("testdump", TRUE)))
f <- function(x) {
  sin(x)
}
f('test')

options(error = NULL)
load("testdump.rda")
?debugger
debugger(testdump)


# (3) traceback
# list recent function calls with parameter values
traceback()
?traceback

# (4) step-wise
# execute code line by line within the debugger
# function debug(): n (execute next line), (c) execute whole function, (q) quit
h <- function(x, y) { 
  f(x) 
  f(y) 
}

debug(h)
h('string_here', 3)
undebug(h)

