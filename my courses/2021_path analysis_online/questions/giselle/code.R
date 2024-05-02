####My main question is FP (a measure of birds sociality) has a "stronger" relation/is better predicted by LV or by TotalA? So 
#i just wanted to compare standardized coefficients and significant relations


ls()
rm(list=ls())
ls()

setwd("E:/")


tabla<-read.csv("./Example Samuel.csv",header=T,sep=";",dec=".")
head(tabla)
#rescaling variables 
tabla$TC<-as.numeric(tabla$TC)
tabla$TotalA<-as.numeric(tabla$TotalA/10)
tabla$Fol<-as.numeric(tabla$Fol)
tabla$Lprop<-as.numeric(tabla$Lprop)
tabla$FP<-as.numeric(tabla$FP*10)

modlist<- '
LV=~Lprop+TC+Fol
FP~TotalA
FP~LV
TotalA~~Lprop+TC
'
fit <- sem (modlist, data=tabla, cluster ="TransectID", estimator="MLR")
summary(fit, fit.measures=T,standardize = T)
standardizedsolution(fit)
semPaths(fit,what='path', 
         whatLabels="std",
         style="ram",
         layout="tree",
         rotation = 4, 
         sizeMan = 7, sizeInt = 7, sizeLat = 7, 
         color = "lightgray",
         edge.label.cex=1.2, 
         label.cex=1.3)

#If i do not use the cluster argument
fitS <- sem (modlist, data=tabla, estimator="MLR")
summary(fitS, fit.measures=T,standardize = T)
standardizedsolution(fitS)
semPaths(fitS,what='path', 
         whatLabels="std",
         style="ram",
         layout="tree",
         rotation = 4, 
         sizeMan = 7, sizeInt = 7, sizeLat = 7, 
         color = "lightgray",
         edge.label.cex=1.2, 
         label.cex=1.3)
