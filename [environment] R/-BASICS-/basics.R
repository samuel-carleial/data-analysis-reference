######################################################################### #
## R Basics
######################################################################### #
##
## Author: Samuel Carleial
## Date: 2020.08
##
######################################################################### #

## variables/vectors, matrices and dataframes
numeric_variable <- rnorm(n=100,mean=10,sd=1.25)
hist(numeric_variable)

categorical_variable <- factor(rbinom(n=100,size=1,prob=.80))
plot(categorical_variable)

my_matrix <- matrix(data=rnorm(100) , ncol=10 , byrow=TRUE)
pairs(my_matrix)

dt <- airquality
summary(dt)


## indexing
numeric_variable[4] # element in a vector
dt[, "Ozone"] # column


## manipulating data
cbind(iris$Sepal.Length, iris$Species)[1:5,]
rbind()
colnames(dt)


## checking and controling
class()
identical(colnames(dt), names(dt))
stopifnot()
all.equal()
isTRUE()
try()


## plot data
par(mfrow=c(2,2)) # split pane in two rows and two columns
hist(numeric_variable)
#boxplot() # comment/uncomment code to control what is going to be run
#barplot()
plot(categorical_variable)
plot(Ozone ~ Solar.R + Wind, data=dt) # plot variable Y as a function of X


## colors: select color to use in plots
library("colorspace")
demo("brewer")
demo("carto")
demo("scico")
demo("viridis")

## modeling data
my_model <- lm(Ozone ~ Solar.R + Wind + Temp, data=dt)
summary(my_model)
car::Anova(my_model, type="III")
par(mfrow=c(2,2)) # split pane for plots
plot(my_model)


## some other stuff that might be done in R
library("TeachingDemos")
?TeachingDemos

ci.examp()
clt.examp()
clt.examp(5)
plot.dice( expand.grid(1:6,1:6), layout=c(6,6) )
faces(rbind(1:3,5:3,3:5,5:7))
plot(1:10, 1:10)
my.symbols( 1:10, 1:10, ms.polygram, n=1:10, inches=0.3 )
x <- seq(1,100)
y <- rnorm(100)
plot(x,y, type="b", col="blue")
clipplot( lines(x,y, type="b", col="red"), ylim=c(par("usr")[3],0))
power.examp()
power.examp(n=25)
power.examp(alpha=0.1)


## format R code: format code scripts by using this shiny application
library("formatR")
tidy_app()


## Remember R functions by using the "spaced repetition" approach
# help remember things and what to learn next in R
# ref: https://github.com/djacobs7/remembr
devtools::install_github( "djacobs7/remembr")
library("remembr")
help(remembr)


######################################################################### #
