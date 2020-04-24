# TABLES IN R ##################################################################

# Observation; tables in R are, in my experience, quite a hard task. Some packages
# could help doing that, but usually it is a lot of work. Also, printing tables
# on plots/Viewer pane usually are done in LaTeX


library('knitr')
#library(devtools)
#install_git('https://github.com/ccolonescu/PoEdata')
library('PoEdata')
library('broom')
library('memisc')
library('stargazer')



# Table for summaries -----------------------------------------------------

FAZER


# Table for statistical models --------------------------------------------



# model example
data('mroz', package='PoEdata')
mroz1 <- mroz[mroz$lfp == 1,] #restricts sample to lfp=1
model1 <- lm(educ ~ exper + I(exper^2) + mothereduc, data = mroz1)

# EXAMPLE 1: kable()
kable(tidy(model1), 
      digits = 4, align = 'c', 
      caption = 'First stage in the 2SLS model for the "wage" equation')

# EXAMPLE 2: memisc::mtable()
mtable(model1)

# EXAMPLE 3: stargazer()
stargazer(model1) # it does not work well in this case


# END ---------------------------------------------------------------------

session_info()
