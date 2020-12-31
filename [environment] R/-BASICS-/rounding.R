
# Since the beginning of computer times, computer language is binary-based (0 or 1;
# yes or no). As such, there is a common and known issue of rounding values by
# computers. We can think at this issue regarding rounding as follows: R has to 
# decide in a binary way to which side a number should be rounded (up or down),
# like to the left or right of the non-integer reference point. R has built-in
# functions for these operations in the base package.


## Documentation
??Round
# ceiling() takes a single numeric argument x and returns a numeric vector containing 
# the smallest integers not less than the corresponding elements of x.
# 
# floor() takes a single numeric argument x and returns a numeric vector containing 
# the largest integers not greater than the corresponding elements of x.
# 
# trunc() takes a single numeric argument x and returns a numeric vector containing 
# the integers formed by truncating the values in x toward 0.
# 
# round() rounds the values in its first argument to the specified number of decimal 
# places (default 0). See ‘Details’ about “round to even” when rounding off a 5.
# 
# signif() rounds the values in its first argument to the specified number of significant digits.
 

## example
x <- rnorm(200, mean=10, sd=1)

par(mfrow=c(2,2))
plot(x, jitter(ceiling(x)), cex=.5);    abline(0,1,col="red")
plot(x, jitter(floor(x)), cex=.5);      abline(0,1,col="red")
plot(x, jitter(as.integer(x)), cex=.5); abline(0,1,col="red")
plot(x, jitter(round(x, 0)), cex=.5);   abline(0,1,col="red")

# Remark: ceiling() overestimates values, whereas floor() underestimates them. Obvious!
# Now, the function as.integer() do the same as floor(). Rounding values to integers, 
# i.e. removing decimals units by round(x,0) approximates values to the 1:1 
# relationship. So, it seems a little bit less skewed to either sides.
