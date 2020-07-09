
## COHEN"S D EFFECT SIZE
##
## sensu Morris (2008): dppc2
effectMorris <- 
  function(data, outcome, time, t1, t2, treatment, contr_level, treat_level) {
  
  # control
  df <- as.data.frame(data)
  stopifnot(c(outcome, treatment, time) %in% names(data))
  stopifnot(c(t1,t2) %in% levels(data[,time]))
  stopifnot(c(contr_level,treat_level) %in% levels(data[,treatment]))
  
  # subset
  data_pre_C <- df[df[,time]==t1 & df[,treatment]==contr_level, outcome]
  data_pre_T <- df[df[,time]==t1 & df[,treatment]==treat_level, outcome]
  data_pos_C <- df[df[,time]==t2 & df[,treatment]==contr_level, outcome]
  data_pos_T <- df[df[,time]==t2 & df[,treatment]==treat_level, outcome]
  
  # pre-calculation
  MpreC <-  mean(data_pre_C[,outcome], na.rm=T)
  MpreT <-  mean(data_pre_T[,outcome], na.rm=T)
  MpostC <- mean(data_pos_C[,outcome], na.rm=T)
  MpostT <- mean(data_pos_T[,outcome], na.rm=T)
  SDpreC <- sd(data_pre_C[,outcome], na.rm=T)
  SDpreT <- sd(data_pre_T[,outcome], na.rm=T)
  nc <- length(na.omit(data_pos_C[,outcome]))
  nt <- length(na.omit(data_pos_T[,outcome]))
  
  # effect size calculation
  differences <- (MpostT-MpreT) - (MpostC-MpreC)
  pooledSD <- sqrt((((nt-1)*SDpreT*SDpreT) + ((nc-1)*SDpreC*SDpreC))/(nt+nc-2))
  cp <- 1-(3/(4*(nt+nc-2)-1))
  dppc2 <- cp*(differences/pooledSD)
  
  return(dppc2)
}