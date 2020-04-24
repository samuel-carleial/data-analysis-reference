# TABBLES IN R #################################################################

library('knitr')
#library('devtools')
#Install_git("https://github.com/ccolonescu/PoEdata")
library('PoEdata')
library('memisc')
library('stargazer')



# Table for summaries -----------------------------------------------------

FAZER


# Table for statistical models --------------------------------------------
# model example
data('mroz')
mroz1 <- mroz[mroz$lfp==1,] # a subset
model1 <- lm(educ ~ exper + I(exper^2) + mothereduc, data = mroz1)

# example 1: tidy()
tidy(model1)

# example 1: kable()
kable(tidy(model1), 
      digits = 4, align = 'c',
      caption = 'First stage in the 2SLS model for the "wage" equation')

# example 2: memisc::mtable()
mtable(model1)

# example 3: stargazer()
stargazer(model1) # does not work all the time


# END ---------------------------------------------------------------------

session_info()
