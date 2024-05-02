####My main question is FP (a measure of birds sociality) has a "stronger" relation/is better predicted by LV or by TotalA? So 
#i just wanted to compare standardized coefficients and significant relations


ls()
rm(list=ls())
ls()

setwd("E:/")


tabla<-read.csv("data.csv",header=T,sep=";",dec=".")
head(tabla)
str(tabla)
ggpairs(tabla[,-1])
summary(tabla)

#rescaling variables 
# tabla$TC<-as.numeric(tabla$TC)
# tabla$TotalA<-as.numeric(tabla$TotalA/10)
# tabla$Fol<-as.numeric(tabla$Fol)
# tabla$Lprop<-as.numeric(tabla$Lprop)
# tabla$FP<-as.numeric(tabla$FP*10)
tabla$TC     <- scale(tabla$TC)
tabla$TotalA <- scale(tabla$TotalA)
tabla$Fol    <- scale(tabla$Fol)
tabla$Lprop  <- scale(tabla$Lprop)
tabla$FP     <- scale(tabla$FP)

modlist<- '
LV=~Lprop+TC+Fol
FP~TotalA
FP~LV
TotalA~~Lprop+TC
'
fit <- sem(modlist, data=tabla, cluster ="TransectID", estimator="MLR")
summary(fit, fit.measures=T,standardize = T)
standardizedsolution(fit)
semPaths(fit)
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
fitS <- sem(modlist, data=tabla, estimator="MLR")
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

par(mfrow=c(1,2))
semPaths(fit)
semPaths(fitS)

# TEST 1 -----------------------------------------------------------------------
# explore latent variable
# Exploratory Factor Analysis (EFA)
library("psych")
temp <- tabla[, c("Lprop", "TC", "Fol")]
corre <- cor(na.omit(temp)) #correlation matrix
cor.plot(corre)
eigen(corre)                #eigenvalues #eigen(correlation_matrix)
scree(corre, factors=FALSE) #scree plot (suggests one factor)
fa.parallel(temp)
# make factors
bfi1 <- fa(temp,1)
print(bfi1, sort=TRUE)
# NOTE that factor has three variables, but Fol does not contribute well (<.3 loading)
print(loadings(bfi1), digits=2)
print(loadings(bfi1), cutoff=.3, digits=2)
rm(bfi1, corre, temp)


# EXAMPLE ----------------------------------------------------------------------
# example from documentation
model <- '
    level: 1
        fw =~ y1 + y2 + y3
        fw ~ x1 + x2 + x3
    level: 2
        fb =~ y1 + y2 + y3
        fb ~ w1 + w2
'
fit_example <- sem(model = model, data = Demo.twolevel, cluster = "cluster")
# NOTE: model fit has two output parts (within and between clusters)
summary(fit_example, fit.measures=T,standardize = T)


