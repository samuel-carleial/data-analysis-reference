# POWER ANALYSIS

library(pwr)
library(WebPower)
library(longpower)

vignette(all=FALSE)

# package base ------------------------------------------------------------

# ref: https://stats.idre.ucla.edu/r/dae/one-way-anova-power-analysis/
# Using groups (predictor of interest with levels; categorical predictor with n group levels)
groupmeans <- c(44,42,40,35,44,45)
p <- power.anova.test(groups = length(groupmeans),
                      between.var = var(groupmeans), 
                      within.var = 100, 
                      power=.8, 
                      sig.level=.05,
                      n=NULL)
p

n <- seq(5,50,by=1) 
p <- power.anova.test(groups = length(groupmeans),
                      between.var = var(groupmeans), 
                      within.var = 100, 
                      power=NULL, 
                      sig.level=.05,
                      n=n)
plot(n, p$power)


# package pwr -------------------------------------------------------------

# ref: https://www.statmethods.net/stats/power.html
#Overview

#Power analysis is an important aspect of experimental design. It allows us to 
#determine the sample size required to detect an effect of a given size with a 
#given degree of confidence. Conversely, it allows us to determine the probability 
#of detecting an effect of a given size with a given level of confidence, under 
#sample size constraints. If the probability is unacceptably low, we would be 
#wise to alter or abandon the experiment.

#The following four quantities have an intimate relationship:
  
#sample size
#effect size
#significance level = P(Type I error) = probability of finding an effect that is not there
#power = 1 - P(Type II error) = probability of finding an effect that is there
#Given any three, we can determine the fourth.

#Power Analysis in R
#The pwr package developed by Stéphane Champely, implements power analysis as 
#outlined by Cohen (!988). Some of the more important functions are listed below.
#function 	power calculations for
#pwr.2p.test 	two proportions (equal n)
#pwr.2p2n.test 	two proportions (unequal n)
#pwr.anova.test 	balanced one way ANOVA
#pwr.chisq.test 	chi-square test
#pwr.f2.test 	general linear model
#pwr.p.test 	proportion (one sample)
#pwr.r.test 	correlation
#pwr.t.test 	t-tests (one sample, 2 sample, paired)
#pwr.t2n.test 	t-test (two samples with unequal n)

#For each of these functions, you enter three of the four quantities (effect size, 
#sample size, significance level, power) and the fourth is calculated.

#The significance level defaults to 0.05. Therefore, to calculate the significance 
#level, given an effect size, sample size, and power, use the option "sig.level=NULL".

#Specifying an effect size can be a daunting task. ES formulas and Cohen's 
#suggestions (based on social science research) are provided below. Cohen's 
#suggestions should only be seen as very rough guidelines. Your own subject 
#matter experience should be brought to bear.

#(To explore confidence intervals and drawing conclusions from samples try this 
#interactive course on the foundations of inference.)

#t-tests
#For t-tests, use the following functions:
  
pwr.t.test(n = , d = , sig.level = , power = , type = c("two.sample", "one.sample", "paired"))

#where n is the sample size, d is the effect size, and type indicates a two-sample t-test, one-sample t-test or paired t-test. If you have unequal sample sizes, use

pwr.t2n.test(n1 = , n2= , d = , sig.level =, power = )

#where n1 and n2 are the sample sizes.

#For t-tests, the effect size is assessed as Cohen's d
#Cohen suggests that d values of 0.2, 0.5, and 0.8 represent small, medium, 
#and large effect sizes respectively.

#You can specify alternative="two.sided", "less", or "greater" to indicate a 
#two-tailed, or one-tailed test. A two tailed test is the default.

#ANOVA
#For a one-way analysis of variance use

pwr.anova.test(k = , n = , f = , sig.level = , power = )

#where k is the number of groups and n is the common sample size in each group.

#For a one-way ANOVA effect size is measured by f where
#Cohen f
#Cohen suggests that f values of 0.1, 0.25, and 0.4 represent small, medium, 
#and large effect sizes respectively.

#Correlations
#For correlation coefficients use

pwr.r.test(n = , r = , sig.level = , power = )

#where n is the sample size and r is the correlation. We use the population 
#correlation coefficient as the effect size measure. Cohen suggests that r 
#values of 0.1, 0.3, and 0.5 represent small, medium, and large effect sizes respectively.

#Linear Models
#For linear models (e.g., multiple regression) use
pwr.f2.test(u =, v = , f2 = , sig.level = , power = )

#where u and v are the numerator and denominator degrees of freedom. 
# We use f2 as the effect size measure.

#cohen f2

#Cohen f2 alternate
#The first formula is appropriate when we are evaluating the impact of a set of 
#predictors on an outcome. The second formula is appropriate when we are evaluating 
#the impact of one set of predictors above and beyond a second set of predictors 
#(or covariates). Cohen suggests f2 values of 0.02, 0.15, and 0.35 represent 
#small, medium, and large effect sizes.

## General linear models (GLMs)
?pwr.f2.test
pwr.f2.test(u = NULL, v = NULL, f2 = NULL, sig.level = 0.05, power = NULL)

#where “u”= numerator degrees of freedom (number of continuous variables + number of dummy codes – 1)
# basically the number of degrees of freedom used
#…and “v”=denominator (error) degrees of freedom
# basically the number of observations or datapoints


#Tests of Proportions
#When comparing two proportions use

pwr.2p.test(h = , n = , sig.level =, power = )

#where h is the effect size and n is the common sample size in each group.

#Cohen h
#Cohen suggests that h values of 0.2, 0.5, and 0.8 represent small, medium, and 
#large effect sizes respectively.

#For unequal n's use

pwr.2p2n.test(h = , n1 = , n2 = , sig.level = , power = )

#To test a single proportion use

pwr.p.test(h = , n = , sig.level = , power = )

#For both two sample and one sample proportion tests, you can specify 
#alternative="two.sided", "less", or "greater" to indicate a two-tailed,
#or one-tailed test. A two tailed test is the default.

#Chi-square Tests
#For chi-square tests use

pwr.chisq.test(w =, N = , df = , sig.level =, power = )

#where w is the effect size, N is the total sample size, and df is the degrees 
#of freedom. The effect size w is defined as

#Cohen w
#Cohen suggests that w values of 0.1, 0.3, and 0.5 represent small, medium, 
#and large effect sizes respectively.


# -> plots -------------------------------------------------------------------

#Creating Power or Sample Size Plots
#The functions in the pwr package can be used to generate power and sample size graphs.

# Plot sample size curves for detecting correlations of
# various sizes.

# range of correlations
r <- seq(.1,.5,.01)
nr <- length(r)

# power values
p <- seq(.4,.9,.1)
np <- length(p)

# obtain sample sizes
samsize <- array(numeric(nr*np), dim=c(nr,np))
for (i in 1:np){
  for (j in 1:nr){
    result <- pwr.r.test(n = NULL, r = r[j],
                         sig.level = .05, power = p[i],
                         alternative = "two.sided")
    samsize[j,i] <- ceiling(result$n)
  }
}

# set up graph
xrange <- range(r)
yrange <- round(range(samsize))
colors <- rainbow(length(p))
plot(xrange, yrange, type="n",
     xlab="Correlation Coefficient (r)",
     ylab="Sample Size (n)" )

# add power curves
for (i in 1:np){
  lines(r, samsize[,i], type="l", lwd=2, col=colors[i])
}

# add annotation (grid lines, title, legend)
abline(v=0, h=seq(0,yrange[2],50), lty=2, col="grey89")
abline(h=0, v=seq(xrange[1],xrange[2],.02), lty=2,
       col="grey89")
title("Sample Size Estimation for Correlation Studies\n
  Sig=0.05 (Two-tailed)")
legend("topright", title="Power", as.character(p),
       fill=colors)


# -> examples ----------------------------------------------------------------
# ->> ex1 ---------------------------------------------------------------------

## Exercise 9.1 P. 424 from Cohen (1988)
# 9.1 Consider a conventional application of MRC, in which a personnel psychologist
# seeks to determine the efficacy of the prediction of sales success in a sample 
# of 95 ( = N) applicants for sales positions using as IVs age, education, amount 
# of prior sales experience, and scores on a verbal aptitude test and extraversion 
# questionnaire. These 5  ( = u) variables comprise set B. 
# What is the power of the F test at a = .05 if the population R~.8 is .10? 
# When R~.a = .10, 12 = .10/(1 -.10) = .1111. For N =95 and u = 5, the error df, 
# v = (N -   u  -1  = 95 -   5  -   1 =) 89. Thus, from (9.3.1) or (9.3.3), 
# A= .1111 X 95 = 10.6. The specification summary thus is 
# a= .05, u = 5, v = 89, A= 10.6. 
# Entering Table 9.3.2 (for a = .05) at block u = 5 for v = 60, power at A = 10 
# is .62 and at). = 12 is  . 72. Linear interpolation finds the power at v = 60 for).
# = 10.6 to be .66. Similarly, linear interpolation at v = 120 between A = 10 (.65) 
# and). = 12 (. 75) finds power for A = 10.6 to be .68. Finally, using equation (9.3.2) 
# for inverse linear interpolation of our v = 89 between .66 (for v = 60) and .68 (for v = 120) gives: . 66 + 1160-1189 1160-11120 (.68 -.66) = .67 . 
# As is frequently the case, we could just as well have done this double interpo-lation by eye and estimated the interpolated power value within .01 of the computed value. Such "guestimated" interpolated power values are usually of quite sufficient accuracy. Thus, if these five IVs together account for lODJo of the variance in sales success in the population, the odds are only two to one that a sample of 95 cases will yield a sample R2 that is significant at a = .05.

pwr.f2.test(u=5,v=89,f2=0.1/(1-0.1),sig.level=0.05,power=NULL)

## Test
pwr.f2.test(u=2, v=NULL, f2=0.15/(1-0.15),sig.level=0.05,power=.75)

## Test
n <- seq(5,200,by=5) 
p <- pwr.f2.test(u=10, v=n, f2=.35, sig.level=.05)
plot(n, p$power)



# ->> ex2 ---------------------------------------------------------------------

# For a one-way ANOVA comparing 5 groups, calculate the
# sample size needed in each group to obtain a power of
# 0.80, when the effect size is moderate (0.25) and a
# significance level of 0.05 is employed.

pwr.anova.test(k=5,f=.25,sig.level=.05,power=.8)

# What is the power of a one-tailed t-test, with a
# significance level of 0.01, 25 people in each group,
# and an effect size equal to 0.75?

pwr.t.test(n=25,d=0.75,sig.level=.01,alternative="greater")

# Using a two-tailed test proportions, and assuming a
# significance level of 0.01 and a common sample size of
# 30 for each proportion, what effect size can be detected
# with a power of .75?

pwr.2p.test(n=30,sig.level=0.01,power=0.75)


# package WebPower --------------------------------------------------------
citation("WebPower")
# Statistical Power Analysis for Repeated Measures ANOVA
help(wp.rmanova)
res <- wp.rmanova(n=seq(10,500,10), ng=3, nm=3, f=.25, nscor=1, alpha=.05, power=NULL, type=0)
plot(res, main="POWER ANALYSIS\nrepeated-measures design\n", cex=.5, col="red")
mtext("(3 groups; 3 assessment points)")

# Statistical Power Analysis for Cluster Randomized Trials with 3 Arms
# it requires clusters (ex: school, communities, where samples are drawn and treatments are applied).
# it does not really apply to a one-population study
help(wp.crt3arm)

#To calculate the statistical power given sample size and effect size:
wp.crt3arm(f = 0.5, n = 20, J = 10, icc = 0.1, alpha = 0.05, power = NULL)
#To generate a power curve given a sequence of sample sizes:
res <- wp.crt3arm(f = 0.5, n = seq(20, 100, 10), J = 10,
                  icc = 0.1, alpha = 0.05, power = NULL)
res
plot(res)


# package longpower -------------------------------------------------------
help(power.mmrm)


# reproduce Table 1 from Lu, Luo, & Chen (2008)
phi1 <- c(rep(1, 6), 2, 2)
phi2 <- c(1, 1, rep(2, 6))
lambda <- c(1, 2, sqrt(1/2), 1/2, 1, 2, 1, 2)
ztest <- ttest1 <- c()
for(i in 1:8){
  Na <- (phi1[i] + lambda[i] * phi2[i])*(qnorm(0.05/2) + qnorm(1-0.90))^2*(0.5^-2)
  Nb <- Na/lambda[i]
  ztest <- c(ztest, Na + Nb)
  v <- Na + Nb - 2
  Na <- (phi1[i] + lambda[i] * phi2[i])*(qt(0.05/2, df = v) + qt(1-0.90, df = v))^2*(0.5^-2)
  Nb <- Na/lambda[i]
  ttest1 <- c(ttest1, Na + Nb)
}
data.frame(phi1, phi2, lambda, ztest, ttest1)

Ra <- matrix(0.25, nrow = 4, ncol = 4)
diag(Ra) <- 1
ra <- c(1, 0.90, 0.80, 0.70)
sigmaa <- 1
power.mmrm(         Ra = Ra, ra = ra, sigmaa = sigmaa, delta = 0.5, power = 0.80)
power.mmrm(N = 174, Ra = Ra, ra = ra, sigmaa = sigmaa, delta = 0.5)
power.mmrm(N = 174, Ra = Ra, ra = ra, sigmaa = sigmaa,              power = 0.80)

power.mmrm(         Ra = Ra, ra = ra, sigmaa = sigmaa, delta = 0.5, power = 0.80, lambda = 2)
power.mmrm(N = 174, Ra = Ra, ra = ra, sigmaa = sigmaa, delta = 0.5,               lambda = 2)
power.mmrm(N = 174, Ra = Ra, ra = ra, sigmaa = sigmaa,              power = 0.80, lambda = 2)

# Extracting paramaters from gls objects with general correlation

# Create time index:
Orthodont$t.index <- as.numeric(factor(Orthodont$age, levels = c(8, 10, 12, 14)))
with(Orthodont, table(t.index, age))

fmOrth.corSym <- gls( distance ~ Sex * I(age - 11), 
                      Orthodont,
                      correlation = corSymm(form = ~ t.index | Subject),
                      weights = varIdent(form = ~ 1 | age) )
summary(fmOrth.corSym)$tTable

C <- corMatrix(fmOrth.corSym$modelStruct$corStruct)[[1]]
sigmaa <- fmOrth.corSym$sigma * 
  coef(fmOrth.corSym$modelStruct$varStruct, unconstrained = FALSE)['14']
ra <- seq(1,0.80,length=nrow(C))
power.mmrm(N=100, Ra = C, ra = ra, sigmaa = sigmaa, power = 0.80)

# Extracting paramaters from gls objects with compound symmetric correlation

fmOrth.corCompSymm <- gls( distance ~ Sex * I(age - 11), 
                           Orthodont,
                           correlation = corCompSymm(form = ~ t.index | Subject),
                           weights = varIdent(form = ~ 1 | age) )
summary(fmOrth.corCompSymm)$tTable

C <- corMatrix(fmOrth.corCompSymm$modelStruct$corStruct)[[1]]
sigmaa <- fmOrth.corCompSymm$sigma *
  coef(fmOrth.corCompSymm$modelStruct$varStruct, unconstrained = FALSE)['14']
ra <- seq(1,0.80,length=nrow(C))
power.mmrm(N=100, Ra = C, ra = ra, sigmaa = sigmaa, power = 0.80)

# Extracting paramaters from gls objects with AR1 correlation

fmOrth.corAR1 <- gls( distance ~ Sex * I(age - 11), 
                      Orthodont,
                      correlation = corAR1(form = ~ t.index | Subject),
                      weights = varIdent(form = ~ 1 | age) )
summary(fmOrth.corAR1)$tTable

C <- corMatrix(fmOrth.corAR1$modelStruct$corStruct)[[1]]
sigmaa <- fmOrth.corAR1$sigma *
  coef(fmOrth.corAR1$modelStruct$varStruct, unconstrained = FALSE)['14']
ra <- seq(1,0.80,length=nrow(C))
power.mmrm(N=100, Ra = C, ra = ra, sigmaa = sigmaa, power = 0.80)
power.mmrm.ar1(N=100, rho = C[1,2], ra = ra, sigmaa = sigmaa, power = 0.80)

