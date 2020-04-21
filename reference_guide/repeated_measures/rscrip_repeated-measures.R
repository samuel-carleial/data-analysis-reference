
set.seed(12345)
rm(list = ls())

# Sources:
## Book: Field 2012 (statistics with R)
## Book: Zuur et al. 2013 (A Beginner's Guide to GLM and GLMM with R)
## Internet: see below

# REPEATED MEASURES demonstrations ----------------------------------------
# There are a number of situations that can arise when the analysis includes between groups effects as well
# as within subject effects. We start by showing 4 example analyses using measurements of depression over 3
# time points broken down by 2 treatment groups. In the first example we see that the two groups differ in
# depression but neither group changes over time. In the second example the two groups grow in depression
# but at the same rate over time.  In the third example, the two groups start off being quite different in
# depression but end up being rather close in depression. The fourth example shows the groups starting off
# at the same level of depression, and one group group increases over time whereas the other group decreases
# over time.

# Note that in the interest of making learning the concepts easier we have taken the liberty of using only a
# very small portion of the output that R provides and we have inserted the graphs as needed to facilitate
# understanding the concepts. The code needed to actually create the graphs in R has been included.

# -> demo1 ----------------------------------------------------------------
# The between groups test indicates that the variable group is significant, consequently in the graph we see
# that the lines for the two groups are rather far apart. The within subject test indicate that there is not
# a significant time effect, in other words, the groups do not change in depression over time. In the graph
# we see that the groups have lines that are flat, i.e. the slopes of the lines are approximately equal to zero.
# Also, since the lines are parallel, we are not surprised that the interaction between time and group is not
# significant.

demo1 <- read.csv("http://www.ats.ucla.edu/stat/data/demo1.csv", sep="\t")
## Convert variables to factor
demo1 <- within(demo1, {
  group <- factor(group)
  time <- factor(time)
  id <- factor(id)
}
)

plot(demo1)

par(cex = .6)

with(demo1, interaction.plot(time, group, pulse,
                             ylim = c(5, 20), lty= c(1, 12), lwd = 3,
                             ylab = "mean of pulse", xlab = "time", trace.label = "group"))

demo1.aov <- aov(pulse ~ group * time + Error(id), data = demo1)
summary(demo1.aov)
rm(demo1, demo1.aov)


# -> demo2 ----------------------------------------------------------------
# The between groups test indicates that the variable group is not significant, consequently in the graph we
# see that the lines for the two groups are rather close together. The within subject test indicate that there
# is a significant time effect, in other words, the groups do change in depression over time. In the graph we
# see that the groups have lines that increase over time. Again, the lines are parallel consistent with the
# finding that the interaction is not significant.

demo2 <- read.csv("http://www.ats.ucla.edu/stat/data/demo2.csv")
## Convert variables to factor
demo2 <- within(demo2, {
  group <- factor(group)
  time <- factor(time)
  id <- factor(id)
})

par(cex = .6)

with(demo2, interaction.plot(time, group, pulse,
                             ylim = c(10, 40), lty = c(1, 12), lwd = 3,
                             ylab = "mean of pulse", xlab = "time", trace.label = "group"))

demo2.aov <- aov(pulse ~ group * time + Error(id), data = demo2)
summary(demo2.aov)
rm(demo2, demo2.aov)


# -> demo3 ----------------------------------------------------------------
# The between groups test indicates that the variable group is significant, consequently in the graph we
# see that the lines for the two groups are rather far apart. The within subject test indicate that there
# is a significant time effect, in other words, the groups do change over time, both groups are getting
# less depressed over time. Moreover, the interaction of time and group is significant which means that
# the groups are changing over time but are changing in different ways, which means that in the graph the
# lines will not be parallel. In the graph we see that the groups have non-parallel lines that decrease
# over time and are getting progressively closer together over time.

demo3 <- read.csv("http://www.ats.ucla.edu/stat/data/demo3.csv")
## Convert variables to factor
demo3 <- within(demo3, {
  group <- factor(group)
  time <- factor(time)
  id <- factor(id)
})

par(cex = .6)

with(demo3, interaction.plot(time, group, pulse,
                             ylim = c(10, 60), lty = c(1, 12), lwd = 3,
                             ylab = "mean of pulse", xlab = "time", trace.label = "group"))

demo3.aov <- aov(pulse ~ group * time + Error(id), data = demo3)
summary(demo3.aov)
rm(demo3, demo3.aov)


# -> demo4 ----------------------------------------------------------------
# The within subject test indicate that the interaction of time and group is significant. The main effect
# of time is not significant. However, the significant interaction indicates that the groups are changing
# over time and they are changing in different ways, in other words, in the graph the lines of the groups
# will not be parallel. The between groups test indicates that there the variable group is significant.
# In the graph for this particular case we see that one group is increasing in depression over time and the
# other group is decreasing in depression over time.

demo4 <- read.csv("http://www.ats.ucla.edu/stat/data/demo4.csv")
## Convert variables to factor
demo4 <- within(demo4, {
  group <- factor(group)
  time <- factor(time)
  id <- factor(id)
})

par(cex = .6)

with(demo4, interaction.plot(time, group, pulse,
                             ylim = c(10, 60), lty = c(1, 12), lwd = 3,
                             ylab = "mean of pulse", xlab = "time", trace.label = "group"))

demo4.aov <- aov(pulse ~ group * time + Error(id), data = demo4)
summary(demo4.aov)
rm(demo4, demo4.aov)


# -> exercise -------------------------------------------------------------
# The data called exer, consists of people who were randomly assigned to two different diets: low-fat and
# not low-fat and three different types of exercise: at rest, walking leisurely and running. Their pulse
# rate was measured at three different time points during their assigned exercise: at 1 minute, 15 minutes
# and 30 minutes.

exer <- read.csv("http://www.ats.ucla.edu/stat/data/exer.csv")
## Convert variables to factor
exer <- within(exer, {
  diet <- factor(diet)
  exertype <- factor(exertype)
  time <- factor(time)
  id <- factor(id)
})
print(exer)

# -> example 1 ------------------------------------------------------------
# Exercise example, model 1 (time and diet)
# Let us first consider the model including diet as the group variable. The graph would indicate that the
# pulse rate of both diet types increase over time but for the non-low fat group (diet=2) the pulse rate
# is increasing more over time than for the low fat group (diet=1)

par(cex=.6)

with(exer, interaction.plot(time, diet, pulse,
                            ylim = c(90, 110), lty = c(1, 12), lwd = 3,
                            ylab = "mean of pulse", xlab = "time", trace.label = "group"))

# Looking at the results we conclude that the effect of time is significant but the interaction of time
# and diet is not significant. The between subject test of the effect of diet is also not significant.
# Consequently, in the graph we have lines that are not flat, in fact, they are actually increasing over
# time, which was expected since the effect of time was significant. Furthermore, the lines are
# approximately parallel which was anticipated since the interaction was not significant.

diet.aov <- aov(pulse ~ diet * time + Error(id), data = exer)
summary(diet.aov)


# -> example 2 ------------------------------------------------------------
# Exercise example, model 2 (time and exercise type)
# Next, let us consider the model including exertype as the group variable.
with(exer, interaction.plot(time, exertype, pulse,
                            ylim = c(80, 130), lty = c(1, 2, 4), lwd = 2,
                            ylab = "mean of pulse", xlab = "time"))

# The interaction of time and exertype is significant as is the effect of time. The between subject test
# of the effect of exertype is also significant. Consequently, in the graph we have lines that are not
# parallel which we expected since the interaction was significant. Furthermore, we see that some of the
# lines that are rather far apart and at least one line is not horizontal which was anticipated since
# exertype and time were both significant.

exertype.aov <- aov(pulse ~ exertype * time + Error(id), data = exer)
summary(exertype.aov)



# -> further issues -------------------------------------------------------
# Missing Data
# Compare aov and lme functions handling of  missing data (under construction).

Variance-Covariance Structures

Independence

As though analyzed using between subjects analysis.

s2
0 s2
0 0 s2 

Compound Symmetry

Assumes that the variance-covariance structure has a single variance (represented by s2) for all 3 of the time points and a single covariance (represented by s1) for each of the pairs of trials.  This structure is illustrated by the half matrix below.

s2
s1 s2
s1 s1 s2 

Unstructured

Assumes that each variance and covariance is unique.   Each trial has its own variance (e.g. s12 is the variance of trial 1) and each pair of trials has its own covariance (e.g. s21 is the covariance of trial 1 and trial2).  This structure is illustrated by the half matrix below.

s12
s21 s22
s31 s32 s32

Autoregressive

Another common covariance structure which is frequently observed in repeated measures data is an autoregressive structure, which recognizes that observations which are more proximate are more correlated than measures that are more distant.  This structure is illustrated by the half matrix below.

s2
sr s2
sr2 sr s2

Autoregressive Heterogeneous Variances

If the variances change over time, then the covariance would look like this.

s12
sr     s22
sr2   sr     s32

# However, we cannot use this kind of covariance structure in a traditional repeated measures analysis
# (using the aov function), but we can use it in the gls function.
# Let's look at the correlations, variances and covariances for the exercise data.

mat <- with(exer, matrix(c(pulse[time==1], pulse[time==2], pulse[time==3]), ncol = 3))
var(mat)
cor(mat)

# Exercise example, model 2 using the gls function
# Even though we are very impressed with our results so far, we are not completely convinced that the variance-covariance
# structure really has compound symmetry. In order to compare models with different variance-covariance structures we have
# to use the gls function (gls = generalized least squares) and try the different structures that we think our data might have.

# Compound Symmetry
# The first model we will look at is one using compound symmetry for the variance-covariance structure. This model should
# confirm the results of the results of the tests that we obtained through the aov function and we will be able to obtain
# fit statistics which we will use for comparisons with our models that assume other variance-covariance structures.

# In order to use the gls function we need to include the repeated structure in our data set object. We do this by using
# the groupedData function and the id variable following the bar notation indicates that observations are repeated within
# id. We then fit the model using the gls function and we use the corCompSymm function in the corr argument because we
# want to use compound symmetry.  We obtain the 95% confidence intervals for the parameter estimates, the estimate of rho
# and the estimated of the standard error of the residuals by using the intervals function.

library(nlme)
longg <- groupedData(pulse ~ as.numeric(exertype) * as.numeric(time) | id, data = exer)
fit.cs <- gls(pulse ~ exertype * time, data = longg, corr = corCompSymm(, form= ~ 1 | id) )
summary(fit.cs)

# Unstructured
# We now try an unstructured covariance matrix. Option "corr = corSymm" specifies that the correlation structure is 
# unstructured. Option "weights = varident(form = ~ 1 | time)" specifies that the variance at each time point can be different. 

fit.un <- gls(pulse ~ exertype * time, data = longg, corr=corSymm(form = ~ 1 | id), weights = varIdent(form = ~ 1 | time))
summary(fit.un)
anova(fit.un)


# Autoregressive
# From previous studies we suspect that our data might actually have an auto-regressive variance-covariance structure so
# this is the model we will look at next. However, for our data the auto-regressive variance-covariance structure does
# not fit our data much better than the compound symmetry does.
fit.ar1 <- gls(pulse ~ exertype * time, data = longg, corr = corAR1(, form= ~ 1 | id))
summary(fit.ar1)
anova(fit.ar1)


# Autoregressive with heterogeneous variances
# Now we suspect that what is actually going on is that the we have auto-regressive covariances and heterogeneous variances.
fit.arh1 <- gls(pulse ~ exertype * time, data = longg, corr = corAR1(, form = ~ 1 | id), weight = varIdent(form = ~ 1 | time))
summary(fit.arh1)
anova(fit.arh1)


# Model comparison (using the anova function)
# We can use the anova function to compare competing models to see which model fits the data best.
anova(fit.cs, fit.un)
anova(fit.cs, fit.ar1)
anova(fit.cs, fit.arh1)

# The two most promising structures are Autoregressive Heterogeneous Variances and Unstructured since these two models have
# the smallest AIC values and the -2 Log Likelihood scores are significantly smaller than the -2 Log Likelihood scores of
# other models.

# Exercise example, model 3 (time, diet and exertype)---using the aov function
# Looking at models including only the main effects of diet or exertype separately does not answer all our questions.
# We would also like to know if the people on the low-fat diet who engage in running have lower pulse rates than the people
# participating in the not low-fat diet who are not running. In order to address these types of questions we need to look at
# a model that includes the interaction of diet and exertype. After all the analysis involving the variance-covariance
# structures we will look at this model using both functions aov and gls.

# In the graph of exertype by diet we see that for the low-fat diet (diet=1) group the pulse rate for the two exercise types:
# at rest and walking, are very close together, indeed they are almost flat, whereas the running group has a higher pulse 
# rate that increases over time. For the not low-fat diet (diet=2) group the same two exercise types: at rest and walking,
# are also very close together and almost flat. For this group, however, the pulse rate for the running group increases
# greatly over time and the rate of increase is much steeper than the increase of the running group in the low-fat diet group.
# The within subject tests indicate that there is a three-way interaction between diet, exertype and time. In other words,
# the pulse rate will depend on which diet you follow, the exercise type you engage in and at what time during the the exercise
# that you measure the pulse. The interactions of time and exertype and diet and exertype are also significant as are the main
# effects of diet and exertype.
par(cex = .6)
with(exer, interaction.plot(time[diet==1], exertype[diet==1], pulse[diet==1],
                            ylim = c(80, 150), lty = c(1, 12, 8),
                            trace.label = "exertype", ylab = "mean of pulse", xlab = "time")); title("Diet = 1")

with(exer, interaction.plot(time[diet==2], exertype[diet==2], pulse[diet==2],
                            ylim = c(80, 150), lty = c(1, 12, 8),
                            trace.label = "exertype", ylab = "mean of pulse", xlab = "time")); title("Diet = 2")

# Looking at the graphs of exertype by diet.
both.aov <- aov(pulse ~ exertype * diet * time + Error(id), data = exer)
summary(both.aov)

# Exercise example, model 3 (time, diet and exertype)--using the gls fuction
# For the gls model we will use the autoregressive heterogeneous variance-covariance structure since we previously observed 
# that this is the structure that appears to fit the data the best (see discussion of variance-covariance structures). We
# do not expect to find a great change in which factors will be significant but we do expect to have a model that has a better
# fit than the anova model.

# The graphs are exactly the same as the anova model and we find that the same factors are significant. However, since the model
# has a better fit we can be more confident in the estimate of the standard errors and therefore we can be more confident in
# the tests and in the findings of significant factors. The model has a better fit than the model only including exertype and
# time because both the -2Log Likelihood and the AIC has decrease dramatically. The -2 Log Likelihood decreased from 579.8 for
# the model including only exertype and time to 505.3 for the current model.

longa <- groupedData(pulse ~ as.numeric(exertype) * as.numeric(diet) * as.numeric(time) | id, data = exer)
both.arh1 <- gls(pulse ~ exertype * diet * time, data=longa, corr=corAR1(, form=~ 1 | id), weight = varIdent(form = ~ 1 | time))
summary(both.arh1)
anova(both.arh1)

# Contrasts and interaction contrasts for model 3
# From the graphs in the above analysis we see that the runners (exertype level 3) have a pulse rate that is increases much
# quicker than the pulse rates of the two other groups. We would like to know if there is a statistically significant
# difference between the changes over time in the pulse rate of the runners versus the change over time in the pulse rate
# of the walkers and the people at rest across diet groups and across time. Furthermore, we suspect that there might be
# a difference in pulse rate over time and across exercise type between the two diet groups. But to make matters even more
# complicated we would like to test if the runners in the low fat diet group are statistically significantly different from
# all the other groups (i.e. the runners in the non-low fat diet, the walkers and the people at rest in both diet groups).
# Since we are being ambitious we also want to test if the runners in the low fat diet group (diet=1) are different from
# the runners in the non-low fat diet group (diet=2).

# In order to implement contrasts coding for diet and exertype we will make copies of the variables. If they were not already
# factors, we would need to convert them to factors first. Note that we are still using the data frame longa which has the
# hierarchy characteristic that we need for the gls function.

longa[, c("ef", "df", "tf")] <- longa[, c("exertype", "diet", "time")]

# Now we can attach the contrasts to the factor variables using the contrasts function. We need to use the contrast coding
# for regression which is discussed in the chapter 6 in our regression web book (note that the coding system is not package
# specific so we arbitrarily choose to link to the SAS web book.) For the contrast coding of ef and tf we first create the
# matrix containing the contrasts and then we assign the contrasts to them. The contrasts coding for df is simpler since
# there are just two levels and we can therefore assign the contrasts directly without having to create a matrix of contrasts.
m <- matrix( c( c(-1/2, 1/2, 0), c(-1/3, -1/3, 2/3) ), ncol=2)
contrasts(longa$ef) <- m
(contrasts(longa$tf) <- m)

(contrasts(longa$df) <- c(-1/2, 1/2))

# Now that we have all the contrast coding we can finally run the model.  Looking at the results the variable ef1 corresponds
# to the contrast of exertype=1 versus exertype=2 and it is not significant indicating that there is no difference between
# the pulse rate of the people at rest and the people who walk leisurely. The variable ef2 corresponds to the contrast of
# exertype=3 versus the average of exertype=1 and exertype=2. This contrast is significant indicating that there is a
# difference between the mean pulse rate of the runners compared to the walkers and the people at rest.  The variable df1
# corresponds to the contrast of the two diets and it is significant indicating that the mean pulse rate of the people on 
# the low-fat diet is different from that of the people on a non-low fat diet.  The interaction ef2:df1 corresponds to the
# contrast of the runners on a low fat diet (people who are in the group exertype=3 and diet=1) versus everyone else.
# This contrast is significant indicating the the mean pulse rate of the runners on a low fat diet is different from everyone 
# else's mean pulse rate.
model.cs <- gls(pulse ~ ef * df * tf, data = longa,
                corr = corCompSymm(, form = ~ 1 | id) )

summary(model.cs)

# The contrasts that we were not able to obtain in the previous code were the tests of the simple effects, i.e. testing
# for difference between the two diets at exertype=3. We would like to test the difference in mean pulse rate of the people 
# following the two diets at a specific level of exertype. We would like to know if there is a difference in the mean pulse 
# rate for runners (exertype=3) in the lowfat diet (diet=1) versus the runners in the non-low fat diet (diet=2).

# In order to obtain this specific contrasts we need to code the contrasts for diet at each level of exertype and include 
# these in the model. For more explanation of why this is the case we strongly urge you to read chapter 5 in our web book 
# that we mentioned before.

# Looking at the results the variable e3d12 corresponds to the contrasts of the runners on the low fat diet versus the runners
# on the non-low fat diet. This contrast is significant indicating that the mean pulse rate of runners on the low fat diet
# is different from that of the runners on a non-low fat diet.
longa$e1d12 <- (-1/2*(longa$exertype==1 & longa$diet==1))
longa$e1d12[longa$exertype==1 & longa$diet==2] <- 1/2

longa$e2d12 <- (-1/2*(longa$exertype==1))
longa$e2d12[longa$exertype==2 & longa$diet==2] <- 1/2

longa$e3d12 <- (-1/2*(longa$exertype==3 & longa$diet==1))
longa$e3d12[longa$exertype==3 & longa$diet==2] <- 1/2

modela.cs <- gls(pulse ~ ef + e1d12 + e2d12 + e3d12 , data = longa,
                 corr = corCompSymm(, form = ~ 1 | id) )
summary(modela.cs)

# Unequally Spaced Time Points
# Modeling Time as a Linear Predictor of Pulse

# We have another study which is very similar to the one previously discussed except that in this new study the pulse
# measurements were not taken at regular time points.  In this study a baseline pulse measurement was obtained at 
# time = 0 for every individual in the study. However, subsequent pulse measurements were taken at less regular time
# intervals.  The second pulse measurements were taken at approximately 2 minutes (time = 120 seconds); the pulse 
# measurement was obtained at approximately 5 minutes (time = 300 seconds); and the fourth and final pulse measurement 
# was obtained at approximately 10 minutes (time = 600 seconds). The data for this study is displayed below.

study2 <- read.csv("http://www.ats.ucla.edu/stat/data/study2.csv")
study2 <- within(study2, {
  id <- factor(id)
  exertype <- factor(exertype)
  diet <- factor(diet)
})
study2[1:20, ]

# In order to get a better understanding of the data we will look at a scatter plot of the data with lines connecting the 
# points for each individual.

## Load
library(lattice)

par(cex = .6)
xyplot(pulse ~ time, data = study2, groups = id,
       type = "o", panel = panel.superpose)

xyplot(pulse ~ time | exertype, data = study2, groups = id,
       type = "o", panel = panel.superpose)

xyplot(pulse ~ time | diet, data = study2, groups = id,
       type = "o", panel = panel.superpose)

# This is a situation where multilevel modeling excels for the analysis of data with irregularly spaced time points. 
# The multilevel model with time as a linear effect is illustrated in the following equations.
Level 1 (time): Pulse = β0j + β1j (Time) + rij  
Level 2 (person): β0j =  γ00  + γ01(Exertype) + u0j
Level 2 (person): β1j =  γ10  + γ11(Exertype) + u1j

# Substituting the level 2 model into the level 1 model we get the following single equations. Note: The random components
# have been placed in square brackets.
Pulse = γ00 + γ01(Exertype) + γ10(Time) + γ11(Exertype*time) + [ u0j + u1j(Time) + rij ]

# Since this model contains both fixed and random components, it can be analyzed using the lme function as shown below.
time.linear <- lme(pulse ~ exertype * time,
                   random = list(id = pdDiag(~ time)), data = study2)
summary(time.linear)
anova(time.linear)

# Graphs of predicted values. The first graph shows just the lines for the predicted values one for each level of exertype.
# It is obvious that the straight lines do not approximate the data very well, especially for exertype group 3. The rest
# of the graphs show the predicted values as well as the observed values. The predicted values are the darker straight
# lines; the line for exertype group 1 is blue, for exertype group 2 it is red and for exertype group 3 the line is green.
# In this graph it becomes even more obvious that the model does not fit the data very well.
fitted <- fitted(time.linear, level=0)

with(study2, plot(time[exertype==3], fitted[exertype==3], ylim = c(50, 150),
                  xlab = "time", ylab = "predicted", type = "b", col = "green"))
with(study2, points(time[exertype==2], fitted[exertype==2],
                    pch = 4, type = "b", col = "red"))
with(study2, points(time[exertype==1], fitted[exertype==1],
                    pch = 16, type = "b", col = "blue"))

xyplot(pulse[exertype==1] ~ time[exertype==1], data = study2, groups = id,
       type = "o", ylim = c(50, 150), xlim = c(0, 800),
       panel = panel.superpose, col = "blue")
with(study2, lines(time[exertype==1], fitted[exertype==1],
                   ylim = c(50, 150),  xlim = c(0, 800),
                   type = "b", col = "dark blue", lwd = 4))

xyplot(pulse[exertype==2] ~ time[exertype==2], data = study2, groups=id,
       type = "o", ylim = c(50, 150), xlim = c(0, 800),
       panel = panel.superpose, col = "red")
with(study2, lines(time[exertype==2], fitted[exertype==2],
                   ylim = c(50, 150),  xlim = c(0, 800),
                   type = "b", col = "dark red", lwd = 4))

xyplot(pulse[exertype==3] ~ time[exertype==3], data = study2, groups = id,
       type = "o", ylim = c(50, 150), xlim = c(0, 800),
       panel = panel.superpose, col = "green")
with(study2, lines(time[exertype==3], fitted[exertype==3],
                   ylim = c(50, 150), xlim = c(0, 800),
                   type = "b", col = "dark green", lwd = 4))

# Modeling Time as a Quadratic Predictor of Pulse
# To model the quadratic effect of time, we add time*time to the model. We see that term is significant.
study2$time2 <- study2$time^2
time.quad <- lme(pulse ~ exertype * time + time2,
                 random = list(id = pdDiag(~ time)), study2)
summary(time.quad)
anova(time.quad)

# Graphs of predicted values. The first graph shows just the lines for the predicted values one for each level of exertype.
# The curved lines approximate the data better than the straight lines of the model with time as a linear predictor. The
# rest of the graphs show the predicted values as well as the observed values. The predicted values are the very curved 
# darker lines; the line for exertype group 1 is blue, for exertype group 2 it is orange and for exertype group 3 the line
# is green. This model fits the data better, but it appears that the predicted values for the exertype group 3 have too
# little curvature and the predicted values for exertype groups 1 and 2 have too much curvature.
fitted2 <- fitted(time.quad, level = 0)
a <- with(study2, data.frame(time, fitted2, exertype)[order(exertype, time), ])

with(a, {
  plot(time[exertype==3], fitted2[exertype==3], ylim = c(50, 150),
       xlab = "time", ylab = "predicted", col = "green", type = "b")
  points(time[exertype==2], fitted2[exertype==2],
         pch = 4, col = "red", type = "b")
  points(time[exertype==1], fitted2[exertype==1],
         pch = 16, col = "blue", type = "b")
  title("Time Quadratic Effect")})

xyplot(pulse[exertype==1] ~ time[exertype==1], groups = id, data = study2,
       ylim = c(50, 150), xlim = c(0, 800), type = "o",
       panel=panel.superpose, col="blue")
with(a, lines(time[exertype==1], fitted2[exertype==1],
              ylim = c(50, 150), xlim = c(0, 800),
              type = "b", col = "dark blue", lwd = 4))

xyplot(pulse[exertype==2] ~ time[exertype==2], groups = id, data = study2,
       ylim=c(50, 150), xlim=c(0, 800), type="o",
       panel=panel.superpose, col="red")
with(a, lines(time[exertype==2], fitted2[exertype==2],
              ylim = c(50, 150), xlim = c(0, 800),
              type = "b", col = "dark red", lwd = 4))

xyplot(pulse[exertype==3] ~time[exertype==3], groups = id, data = study2,
       ylim = c(50, 150), xlim = c(0, 800), type = "o",
       panel = panel.superpose, col = "green")
with(a, lines(time[exertype==3], fitted2[exertype==3],
              ylim = c(50, 150), xlim = c(0, 800),
              type = "b", col = "dark green", lwd = 4))

# Modeling Time as a Quadratic Predictor of Pulse, Interacting by Exertype
# We can include an interaction of time*time*exertype to indicate that the different exercises not only show different
# linear trends over time, but that they also show different quadratic trends over time, as shown below.  The time*time*exertype
# term is significant.

time.quad2 <- lme(pulse ~ exertype * time + exertype * time2, random = list(id = pdDiag(~ time)), data = study2)
summary(time.quad2)
anova(time.quad2)

# Graphs of predicted values. The first graph shows just the lines for the predicted values one for each level of exertype.
# The lines now have different degrees of curvature which approximates the data much better than the other two models. 
# The rest of graphs show the predicted values as well as the observed values. The line for exertype group 1 is blue, for
# exertype group 2 it is orange and for exertype group 3 the line is green. This model fits the data the best with more 
# curvature for exertype group 3 and less curvature for exertype groups 1 and 2.
fitted3 <- fitted(time.quad2, level = 0)
a <- with(study2,
          data.frame(time, fitted3, exertype)[order(exertype, time), ])

with(a, {
  plot(time[exertype==3], fitted3[exertype==3], ylim = c(50, 150),
       xlab = "time", ylab = "predicted", col = "green", type = "b")
  points(time[exertype==2], fitted3[exertype==2],
         pch = 4, col = "red", type = "b")
  points(time[exertype==1], fitted3[exertype==1],
         pch = 16,  col = "blue", type = "b")
  title("Time Quadratic Effect")})

xyplot(pulse[exertype==1] ~ time[exertype==1], groups = id, data = study2,
       ylim = c(50, 150), xlim = c(0, 800), type = "o",
       panel = panel.superpose, col = "blue")
with(a, lines(time[exertype==1], fitted3[exertype==1],
              ylim = c(50, 150), xlim = c(0, 800),
              type = "b", col = "dark blue", lwd = 4))

xyplot(pulse[exertype==2] ~ time[exertype==2], groups = id, data = study2,
       ylim = c(50, 150), xlim = c(0, 800), type = "o",
       panel = panel.superpose, col = "red")
with(a, lines(time[exertype==2], fitted3[exertype==2],
              ylim = c(50, 150), xlim = c(0, 800),
              type = "b", col = "dark red", lwd = 4))

xyplot(pulse[exertype==3] ~ time[exertype==3], groups = id,  data = study2,
       ylim = c(50, 150), xlim = c(0, 800), type = "o",
       panel = panel.superpose, col = "green")
with(a, lines(time[exertype==3], fitted3[exertype==3],
              ylim = c(50, 150), xlim = c(0, 800),
              type = "b", col = "dark green", lwd = 4))


# example 11 --------------------------------------------------------------

library(nlme)
data(ergoStool)
summary(lme(effort ~ Type, data = ergoStool, method = "ML", random = ~ 1 | Subject))



# example 12: Limosa data (Zuur) ------------------------------------------

Limosa <- read.table(file.choose(), header = T, sep = "")
Limosa$fID <- factor(Limosa$ID)
Limosa$fPeriod <- factor(Limosa$Period, levels = c(0, 1, 2),labels = c("Summer", "LSummer.Fall", "Winter"))
Limosa$fSex <- factor(Limosa$Sex, levels = c(0, 1, 2), labels = c("Unk", "F", "M"))
coplot(IntakeRate ~ Time | fPeriod * fSex, data = Limosa, xlab = c("Time (hours)"))

xyplot(IntakeRate ~ Time | fID, data = Limosa,
       panel=function(x, y) {
         panel.xyplot(x, y, col = 1, cex = 0.5, pch = 1)
         panel.grid(h = -1, v = 2)
         panel.abline(v = 0, lty = 2)
         if (length(x) > 5) panel.loess(x, y, span = 0.9, col = 1, lwd = 2)
       } )

Limosa$Time2 <- Limosa$Time^2 - mean(Limosa$Time^2)
M.lm <- lm(IntakeRate ~ Time + Time2 + fPeriod + fSex, data = Limosa)
drop1(M.lm, test = "F")
plot(fitted(M.lm), resid(M.lm))

M1.gls <- gls(IntakeRate ~ Time + Time2 + fPeriod + fSex, data = Limosa)
summary(Limosa)
E <- resid(M1.gls)
op <- par(mfrow = c(2, 2))
boxplot(E ~ Limosa$fPeriod, main = "Period")
abline(0, 0)
boxplot(E ~ Limosa$fSex, main = "Sex")
abline(0, 0)
boxplot(E ~ Limosa$fSex * Limosa$fPeriod, main = "Sex & Period")
abline(0, 0)
boxplot(E ~ Limosa$ID, main = "Day")
abline(0, 0)
par(op)
rm(M1.gls)

# choose appropriate variance structure
M1.lme <- lme(IntakeRate ~ Time + Time2 + fPeriod + fSex, data = Limosa
              , weights = varIdent(form =~ 1 | fSex * fPeriod)
              , random =~ 1 | fID, method = "REML")
# find optimal fixed structure
M1.lme <- lme(IntakeRate ~ Time + Time2 + fPeriod + fSex, data = Limosa,
              weights = varIdent(form =~ 1 | fSex * fPeriod), random =~ 1 | fID, method = "ML")
M1.lmeA <- update(M1.lme, .~. -Time2)
M1.lmeB <- update(M1.lme, .~. -fPeriod)
M1.lmeC <- update(M1.lme, .~. -fSex)
anova(M1.lme, M1.lmeA)
anova(M1.lme, M1.lmeB)
anova(M1.lme, M1.lmeC)
M4.lme <- lme(IntakeRate ~ fSex, data = Limosa,
               weights = varIdent(form =~ 1 | fSex * fPeriod),
               random =~ 1 | fID, method = "ML")
M4.lmeA <- update(M4.lme, .~. -fSex)
anova(M4.lme, M4.lmeA)

# refit with REML
M4.lme <- lme(IntakeRate ~ fSex, data = Limosa,
              weights = varIdent(form =~ 1 | fSex * fPeriod),
              random =~ 1 | fID, method = "REML")
summary(M4.lme)

# see this too: -----------------------------------------------------------

https://gribblelab.wordpress.com/2009/03/09/repeated-measures-anova-using-r/

mydata

dvm <- with(mydata, cbind(dv[myfactor=="f1"], dv[myfactor=="f2"], dv[myfactor=="f3"]))
dvm

mlm1 <- lm(dvm ~ 1)
mlm1

rfactor <- factor(c("f1","f2","f3"))
rfactor

mlm1.aov <- Anova(mlm1, idata = data.frame(rfactor), idesign = ~rfactor, type="III")
summary(mlm1.aov, multivariate=F)

contrastD <- dvm[,1]-dvm[,2]
t.test(contrastD)



# -> example used by Field 2002 -------------------------------------------

LMEfull <- lme(pssi ~ treatment + time + treatment*time
               , weights = varIdent(form = ~1 | time)
               , random = list(id = ~1)
               , method = "ML"
               , data = data_model)



# END ---------------------------------------------------------------------

sessionInfo()
