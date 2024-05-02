############################################################################## #
## Effect size calculation
############################################################################## #
## Author: 		    Samuel Carleial
## Description: 	-
## Last update: 	2020.07.13

############################################################################## #
## Cohen's effect size #########################################################
############################################################################## #

## sensu Morris (2008): dppc2
## use: for pre-/post-test control vs. treatment group design
## ref: Morris, S.B. (2008). Estimating effect sizes from pretest-posttest-control group designs. Organizational research methods, 11(2), 364-386.

effectMorris <- 
  function(data, outcome, time, t1, t2, treatment, contr_level, treat_level) {
  
  # control
  df <- data.frame(data)
  stopifnot(c(outcome, treatment, time) %in% names(data))
  stopifnot(c(t1,t2) %in% levels(data[,time]))
  stopifnot(c(contr_level,treat_level) %in% levels(data[,treatment]))
  
  # subset
  data_pre_C <- df[df[,time]==t1 & df[,treatment]==contr_level, outcome]
  data_pre_T <- df[df[,time]==t1 & df[,treatment]==treat_level, outcome]
  data_pos_C <- df[df[,time]==t2 & df[,treatment]==contr_level, outcome]
  data_pos_T <- df[df[,time]==t2 & df[,treatment]==treat_level, outcome]
  
  # pre-calculation
  MpreC <-  mean(data_pre_C, na.rm=T)
  MpreT <-  mean(data_pre_T, na.rm=T)
  MpostC <- mean(data_pos_C, na.rm=T)
  MpostT <- mean(data_pos_T, na.rm=T)
  SDpreC <- sd(data_pre_C, na.rm=T)
  SDpreT <- sd(data_pre_T, na.rm=T)
  nc <- length(na.omit(data_pos_C))
  nt <- length(na.omit(data_pos_T))
  
  # effect size calculation
  differences <- (MpostT-MpreT) - (MpostC-MpreC)
  pooledSD <- sqrt((((nt-1)*SDpreT*SDpreT) + ((nc-1)*SDpreC*SDpreC))/(nt+nc-2))
  cp <- 1-(3/(4*(nt+nc-2)-1))
  dppc2 <- cp*(differences/pooledSD)
  
  return(dppc2)
  }

############################################################################## #

## Cohen's d[z]: standard deviation scores used for correlated groups (repeated measures)
## use: standardized mean difference effect size for within-subjects designs
## using a formula:
## ref: Cohen, J. (1977). Statistical power analysis for the behavioral sciences. Routledge.
## ref: Lakens, D. (2013). Calculating and reporting effect sizes to facilitate cumulative science: a practical primer for t-tests and ANOVAs. Frontiers in psychology, 4, 863.
effectCohensDz.1 <-
  function(data, id, time, t1, t2, outcome) {

    df <- data.frame(data)
    stopifnot(c(outcome, time, id) %in% names(data))
    stopifnot(c(t1,t2) %in% levels(data[,time]))
    
    df <- df[df[,time]==t1 | df[,time]==t2, c(time, outcome)]
    df <- df[complete.cases(df),]
    
    match <- sort(unique(intersect(df[df[,time]==t1,id], df[df[,time]==t2,id])))
    df <- df[order(df[,time]),]
    df1 <- df[df[,time]==t1,]
    df2 <- df[df[,time]==t2,]
    df1 <- df1[df1[,id] %in% match,]
    df2 <- df2[df2[,id] %in% match,]
    stopifnot(identical(nrow(df1),nrow(df2)))
    
    # variables preparation
    n <- nrow(df1)
    m1 <- mean(df1[,outcome])
    m1 <- mean(df2[,outcome])
    Mdiff <- mean(m2 - m1)
    sd1 <- sd(df1[,outcome])
    sd2 <- sd(df2[,outcome])
    corr <- cor(df1[,outcome], df2[,outcome])
    Sdiff <- (sqrt((sd1^2)+(sd2^2)-(2*corr*sd1*sd2)))
    
    Dz <- Mdiff/sqrt((sum((apply(cbind(df1[,outcome],df2[,outcome]),1,diff)-Mdiff)^2))/(n-1))
    return(Dz)
  }

## using a t-test:
## ref: Rosenthal, R. (1991). Meta-analytic procedures for social research. Newbury Park, CA: SAGE Publications, Incorporated.
effectCohensDz.2 <-
  function(data, id, time, t1, t2, outcome) {
    
    df <- data.frame(data)
    stopifnot(c(outcome, time, id) %in% names(data))
    stopifnot(c(t1,t2) %in% levels(data[,time]))
    
    df <- df[df[,time]==t1 | df[,time]==t2, c(time, outcome)]
    df <- df[complete.cases(df),]
    
    match <- sort(unique(intersect(df[df[,time]==t1,id], df[df[,time]==t2,id])))
    df <- df[order(df[,time]),]
    df1 <- df[df[,time]==t1,]
    df2 <- df[df[,time]==t2,]
    df1 <- df1[df1[,id] %in% match,]
    df2 <- df2[df2[,id] %in% match,]
    stopifnot(identical(nrow(df1),nrow(df2)))
    
    test <- t.test(df2[,outcome], df1[,outcome], paired = T, alternative = "two.sided")
    Dz <- test$statistic/sqrt(nrow(df1))
    return(Dz)
    }

############################################################################## #

## Cohen's d[RM] (not recommended by Lakens (2013))
## use: the equivalent of Cohen's d for repeated measures. Cohen's d[RM] controls for the correlation between the two sets of measurements
## using a formula:
## ref: Morris, S.B., and DeShon, R.P. (2002). Combining effect size estimates in meta-analysis with repeated measures and independent-groups designs. Psychol. Methods 7, 105–125
effectCohensDrm <-
  function(data, id, time, t1, t2, outcome) {
    
    df <- data.frame(data)
    stopifnot(c(outcome, time, id) %in% names(data))
    stopifnot(c(t1,t2) %in% levels(data[,time]))
    
    df <- df[df[,time]==t1 | df[,time]==t2, c(time, outcome)]
    df <- df[complete.cases(df),]
    
    match <- sort(unique(intersect(df[df[,time]==t1,id], df[df[,time]==t2,id])))
    df <- df[order(df[,time]),]
    df1 <- df[df[,time]==t1,]
    df2 <- df[df[,time]==t2,]
    df1 <- df1[df1[,id] %in% match,]
    df2 <- df2[df2[,id] %in% match,]
    stopifnot(identical(nrow(df1),nrow(df2)))
    
    # variables preparation
    n <- nrow(df1)
    m1 <- mean(df1[,outcome])
    m1 <- mean(df2[,outcome])
    Mdiff <- mean(m2 - m1)
    sd1 <- sd(df1[,outcome])
    sd2 <- sd(df2[,outcome])
    corr <- cor(df1[,outcome], df2[,outcome])
    Sdiff <- (sqrt((sd1^2)+(sd2^2)-(2*corr*sd1*sd2)))
    
    Drm <- (Mdiff/Sdiff) * sqrt(2*(1-corr))
    return(Drm)
  }

############################################################################## #
############################################################################## #
############################################################################## #