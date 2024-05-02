# TABLES IN R ##################################################################

library("knitr")
#library("devtools")
#Install_git("https://github.com/ccolonescu/PoEdata")
library("PoEdata")
library("memisc")
library("stargazer")
library("sjPlot")
options(digits = 4)


# Table for summaries -----------------------------------------------------

# data.frame example
x <- mtcars

x
print.data.frame(x)

library("stargazer")
# note that the function summarises the columns, transposing to rows
stargazer(x, type = "text", out = NULL)

library("knitr")
kable(x, digits = 2, caption = "A table produced by printr.")

library("pander")
pander(x)

library("rhandsontable")
rhandsontable(x, rowHeaders = NULL)

library("gridExtra")
grid.table(x)

library("formattable")
# ref: https://www.littlemissdata.com/blog/prettytables
formattable(x)


# Table for statistical models --------------------------------------------

# model example
data("mroz")
mroz1 <- mroz[mroz$lfp==1,] # a subset
model1 <- lm(educ ~ exper + I(exper^2) + mothereduc, data = mroz1)

# example 1: tidy()
tidy(model1)

# example 1: kable()
kable(tidy(model1),
      digits = 4, align = "c",
      caption = "First stage in the 2SLS model for the 'wage' equation")

# example 2: memisc::mtable()
mtable(model1)

# example 3: stargazer()
stargazer(model1) # does not work all the time

# example 4: tab_model()
tab_model(model1)

# END ---------------------------------------------------------------------

session_info()
