#-------------------------------------------------------------------------------
# DEMONSTRATION EXAMPLES -------------------------------------------------------
#-------------------------------------------------------------------------------
# mtcars dataset
# The data was extracted from the 1974 Motor Trend US magazine, and comprises 
# fuel consumption and 10 aspects of automobile design and performance for 32 
# automobiles (1973–74 models).
data("mtcars")
help("mtcars")
mtcars

# Hypothesis: car weight is determined by gross horsepower and nr. of cylinders,
# but horsepower is in turn defined by cylinder number.

# model
m1 <- '
    # measurement part
    
    # regression part
      wt ~ hp + cyl
      hp ~ cyl
    
    # residual correlations

'

# inspect model
fit1 <- sem(m1, data=mtcars)     # fit SEM model
summary(fit1, fit.measures=TRUE) # summary of model output
semPaths(fit1)                   # plot SEM model
# NOTE: Does the model has a good fit? How can you interpret the output?

mtcars <- mtcars %>%
  mutate(hp = scale(hp),
         wt = scale(wt))


#-------------------------------------------------------------------------------
# airquality dataset
# Daily air quality measurements in New York, May to September 1973.
data("airquality")
help("airquality")

# Hypothesis: the air quality is determined by a number of measurable aspects,
# namely solar radiation and ozone concentration. In addition, air quality might
# also be affecged by wind, temperature and season of the year. Common sense also
# says that temperature and wind are highly correlated measures.

# preparation
airquality <- airquality %>%
  mutate(Summer = ifelse(Month %in% c(7,8), 1, 0))

# model
m2 <- '
    # measurement part
      airquality =~ Ozone + Solar.R
    
    # regression part
      airquality ~ Wind + Temp + Summer
    
    # residual correlations
      Wind ~~ Temp
'

# inspect model
fit2 <- sem(m2, data=airquality)
summary(fit2, fit.measures=TRUE)
modificationindices(fit2, sort.=TRUE) # verify possible model changes
semPaths(fit2)
# NOTE: model fit is not good. Try removing Summer from the model (non-significant)


#-------------------------------------------------------------------------------
# swiss dataset
# Standardized fertility measure and socio-economic indicators for each of 47 
# French-speaking provinces of Switzerland at about 1888.
data("swiss")
help("swiss")
swiss

# preparation
swiss <- scale(swiss)

# model
m3 <- '
    # measurement part
      MenPower       =~ Agriculture + Examination
      NormAcceptance =~ Education + Catholic #+ Infant.Mortality
    
    # regression part
      Fertility      ~ MenPower + NormAcceptance
    
    # residual correlations

'

# inspect model
fit3 <- sem(m3, data=swiss)
lavInspect(fit3, "cov.lv")
summary(fit3, fit.measures=TRUE)
modificationindices(fit3, sort.=TRUE) # verify possible model changes
semPaths(fit3)
# NOTE: warning refers to the fact that latent variables are neg. correlated (not an error)
# NOTE: model fit is not good. Try removing Infant.Mortality out of NormAcceptance


#-------------------------------------------------------------------------------
# PoliticalDemocracy dataset (classical example)
# The ‘famous’ Industrialization and Political Democracy dataset. This dataset 
# is used throughout Bollen's 1989 book (see pages 12, 17, 36 in chapter 2, 
# pages 228 and following in chapter 7, pages 321 and following in chapter 8).
# The dataset contains various measures of political democracy and industrialization 
# in developing countries.
data("PoliticalDemocracy")
help("PoliticalDemocracy")

m4 <- ' 
  # measurment part
     ind60 =~ x1 + x2 + x3
     dem60 =~ y1 + a*y2 + b*y3 + c*y4
     dem65 =~ y5 + a*y6 + b*y7 + c*y8

  # regression part
    dem60 ~ A*ind60
    dem65 ~ B*ind60 + C*dem60

  # residual correlations
    y1 ~~ y5
    y2 ~~ y4 + y6
    y3 ~~ y7
    y4 ~~ y8
    y6 ~~ y8
  
  # mediation part
    DirectEffect  := B
    IndirectEffect:= A+C
'

fit4 <- sem(m4, data=PoliticalDemocracy)
summary(fit4, fit.measures = TRUE)
semPaths(fit4, "std", layout="tree2")
lavaanPlot(fit4)
# NOTE: identify if there is full mediation. What about model interpretation?

