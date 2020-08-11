
# Computer language is based on 01s, yes/no since the begining of times. As such, 
# we face a common and known issue of rounding values. Since R is a computer 
# language as well, it needs to make a binary decision on side "A" or "B", ie. 
# left or right of the non-integer reference point.

## example
x <- rnorm(200, mean=10, sd=1)

par(mfrow=c(2,2))
plot(x, jitter(ceiling(x)), cex=.5);    abline(0,1,col="red")
plot(x, jitter(floor(x)), cex=.5);      abline(0,1,col="red")
plot(x, jitter(as.integer(x)), cex=.5); abline(0,1,col="red")
plot(x, jitter(round(x, 0)), cex=.5);   abline(0,1,col="red")

# Remark: ceiling overestimates values, whereas floor underestimates them. Obvious!
# Now, the function as.integer do the same as for floor. Rounding values to integers, 
# ie. removing decimals units by round(x,0) approximates values to the 1:1 
# relationship. So, it seems a little bit less skewed to either sides.