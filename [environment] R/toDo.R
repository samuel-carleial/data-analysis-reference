library("DSS")
DMLtest()





## Not run: 
require(bsseq)

## first read in methylation data.
path <- file.path(system.file(package="DSS"), "extdata")
dat1.1 <- read.table(file.path(path, "cond1_1.txt"), header=TRUE)
dat1.2 <- read.table(file.path(path, "cond1_2.txt"), header=TRUE)
dat2.1 <- read.table(file.path(path, "cond2_1.txt"), header=TRUE)
dat2.2 <- read.table(file.path(path, "cond2_2.txt"), header=TRUE)

## make BSseq objects
BSobj <- makeBSseqData( list(dat1.1, dat1.2, dat2.1, dat2.2),
                        c("C1","C2", "N1", "N2") )

##  DML test without smoothing 
dmlTest <- DMLtest(BSobj, group1=c("C1", "C2"), group2=c("N1", "N2"))
head(dmlTest)

## For whole-genome BS-seq data, perform DML test with smoothing
require(bsseqData)
data(BS.cancer.ex)
## take a small portion of data and test
BSobj <- BS.cancer.ex[10000:15000,]
dmlTest <- DMLtest(BSobj, group1=c("C1", "C2", "C3"), group2=c("N1","N2","N3"), 
                   smoothing=TRUE, smoothing.span=500)
head(dmlTest)
plot(dmlTest)

require(bsseq)
require(bsseqData)
data(BS.cancer.ex)

## takea small portion of data and test
BSobj <- BS.cancer.ex[140000:150000,]
dmlTest <- DMLtest(BSobj, group1=c("C1", "C2", "C3"), group2=c("N1","N2","N3"),
                   smoothing=TRUE, smoothing.span=500)

## call DMR based on test results
dmrs <- callDMR(dmlTest)

## visualize one DMR
showOneDMR(dmrs[3,], BSobj)


A <- read.csv2("/Users/samuelcarleial/git_projects/courses/ucdavis_intro_epi_analysis/exercises/epigenetics_WGBS/DMR.ATAC.txt"
              ,sep="\t", header = F)

.libPaths()
.libPaths("/etc/apache2/")

limma::lmFit()
do.call()


# Power Analysis (for EWAS) ----------------------------------------------------

# installation
# if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
# BiocManager::install("pwrEWAS")

# load package and see example
library("pwrEWAS")
?pwrEWAS
browseVignettes("pwrEWAS")
.libPaths()

pwrEWAS_shiny()

# -> example 1 #####
# power_test.RData
load("/Users/samuelcarleial/git_projects/courses/ucdavis_intro_epi_analysis/exercises/pwrEWAS/power_test.RData")
# power_test <- pwrEWAS(minTotSampleSize = 50,
#                       maxTotSampleSize = 100,
#                       SampleSizeSteps = 5,
#                       NcntPer = 0.5,
#                       targetDelta = c(seq(from=0.01, to=0.10, by=0.05), 0.2, 0.3, 0.4, 0.5),
#                       J = 3e5,
#                       targetDmCpGs = 100,
#                       tissueType = "Saliva",
#                       detectionLimit = 0.01,
#                       DMmethod = "limma",
#                       FDRcritVal = 0.05,
#                       core = 4,
#                       sims = 100)
str(power_test)
pwrEWAS_deltaDensity(power_test)
pwrEWAS_powerPlot(power_test[,,1])
rm(power_test)
round(seq(0.001,0.050,length.out = 4),3)

# -> example 2 #####
power_test <- pwrEWAS(minTotSampleSize = 50,
                      maxTotSampleSize = 100,
                      SampleSizeSteps = 5,
                      NcntPer = 0.5,
                      targetDelta =0.5,
                      J = 1000,
                      targetDmCpGs = 100,
                      tissueType = "Saliva",
                      detectionLimit = 0.01,
                      DMmethod = "limma",
                      FDRcritVal = 0.05,
                      core = 4,
                      sims = 50)
str(power_test)
pwrEWAS_deltaDensity(power_test)
pwrEWAS_powerPlot(power_test)
rm(power_test)


# -> reference manual ----------------------------------------------------------
# usage
# pwrEWAS(minTotSampleSize, maxTotSampleSize, SampleSizeSteps, NcntPer,targetDelta = NULL, deltaSD = NULL, J = 1e+05, targetDmCpGs,tissueType = c("Adult (PBMC)", "Saliva", "Sperm", "Lymphoma","Placenta", "Liver", "Colon", "Blood adult", "Blood 5 year olds","Blood newborns", "Cord-blood (whole blood)", "Cord-blood (PBMC)"),detectionLimit = 0.01, DMmethod = c("limma", "t-test (unequal var)","t-test (equal var)", "Wilcox rank sum", "CPGassoc"),FDRcritVal = 0.05, core = 1, sims = 50)
# pwrEWAS_shiny() # dinamically


# power analysis
# example 1
outDelta <- pwrEWAS(minTotSampleSize = 10,maxTotSampleSize = 20,SampleSizeSteps = 10,NcntPer = 0.5,targetDelta = c(0.2, 0.5),J = 1000,targetDmCpGs = 10,tissueType = "Adult (PBMC)",detectionLimit = 0.01,DMmethod = "limma",FDRcritVal = 0.05,core = 2,sims = 30)
# example 2
outSD <- pwrEWAS(minTotSampleSize = 10,maxTotSampleSize = 20,SampleSizeSteps = 10,NcntPer = 0.5,deltaSD = c(0.02, 0.03),J = 1000,targetDmCpGs = 10,tissueType = "Adult (PBMC)",detectionLimit = 0.01,DMmethod = "limma",FDRcritVal = 0.05,core = 2,sims = 30)


# density plots
# example 1
outDelta <- pwrEWAS(minTotSampleSize = 10,maxTotSampleSize = 20,SampleSizeSteps = 10,NcntPer = 0.5,targetDelta = c(0.2, 0.5),J = 1000,targetDmCpGs = 10,tissueType = "Adult (PBMC)",detectionLimit = 0.01,DMmethod = "limma",FDRcritVal = 0.05,core = 2,sims = 30)
pwrEWAS_deltaDensity(data = outDelta$deltaArray, detectionLimit = 0.01, sd = FALSE)
# example 2
outSD <- pwrEWAS(minTotSampleSize = 10,maxTotSampleSize = 20,SampleSizeSteps = 10,NcntPer = 0.5,deltaSD = c(0.02, 0.03),J = 1000,targetDmCpGs = 10,tissueType = "Adult (PBMC)",detectionLimit = 0.01,DMmethod = "limma",FDRcritVal = 0.05,core = 2,sims = 30)
pwrEWAS_deltaDensity(data = outSD$deltaArray, detectionLimit = 0.01, sd = TRUE)


# power plot
# example 1
outDelta <- pwrEWAS(minTotSampleSize = 10,maxTotSampleSize = 20,SampleSizeSteps = 10,NcntPer = 0.5,targetDelta = c(0.2, 0.5),J = 1000,targetDmCpGs = 10,tissueType = "Adult (PBMC)",detectionLimit = 0.01,DMmethod = "limma",FDRcritVal = 0.05,core = 2,sims = 30)
pwrEWAS_powerPlot(data = outDelta$powerArray, sd = FALSE)
# example 2
outSD <- pwrEWAS(minTotSampleSize = 10,maxTotSampleSize = 20,SampleSizeSteps = 10,NcntPer = 0.5,deltaSD = c(0.02, 0.03),J = 1000,targetDmCpGs = 10,tissueType = "Adult (PBMC)",detectionLimit = 0.01,DMmethod = "limma",FDRcritVal = 0.05,core = 2,sims = 30)
pwrEWAS_powerPlot(data = outSD$powerArray, sd = TRUE)


# -> documentation R script ----------------------------------------------------
## ----usage, warning=FALSE, message=FALSE, eval=TRUE, results="hide"-----------
# providing the targeted maximal difference in DNAm
results_targetDelta <- pwrEWAS(minTotSampleSize = 10,
                               maxTotSampleSize = 50,
                               SampleSizeSteps = 10,
                               NcntPer = 0.5,
                               targetDelta = c(0.2, 0.5),
                               J = 100,
                               targetDmCpGs = 10,
                               tissueType = "Saliva",
                               detectionLimit = 0.01,
                               DMmethod = "limma",
                               FDRcritVal = 0.05,
                               core = 6,
                               sims = 50)

# providing the targeted maximal difference in DNAm
results_deltaSD <- pwrEWAS(minTotSampleSize = 10,
                           maxTotSampleSize = 50,
                           SampleSizeSteps = 10,
                           NcntPer = 0.5,
                           deltaSD = c(0.02, 0.05),
                           J = 100,
                           targetDmCpGs = 10,
                           tissueType = "Saliva",
                           detectionLimit = 0.01,
                           DMmethod = "limma",
                           FDRcritVal = 0.05,
                           core = 4,
                           sims = 50)


## ----example running pwrEWAS targetDelta, warning=FALSE, message=FALSE, eval=FALSE, results="hide"----
#  library(pwrEWAS)
#  set.seed(1234)
#  results_targetDelta <- pwrEWAS(minTotSampleSize = 20,
#      maxTotSampleSize = 260,
#      SampleSizeSteps = 40,
#      NcntPer = 0.5,
#      targetDelta = c(0.02, 0.10, 0.15, 0.20),
#      J = 100000,
#      targetDmCpGs = 2500,
#      tissueType = "Blood adult",
#      detectionLimit = 0.01,
#      DMmethod = "limma",
#      FDRcritVal = 0.05,
#      core = 4,
#      sims = 50)
#  
#  results_deltaSD <- pwrEWAS(minTotSampleSize = 20,
#      maxTotSampleSize = 260,
#      SampleSizeSteps = 40,
#      NcntPer = 0.5,
#      deltaSD = c(0.00390625, 0.02734375, 0.0390625, 0.052734375),
#      J = 100000,
#      targetDmCpGs = 2500,
#      tissueType = "Blood adult",
#      detectionLimit = 0.01,
#      DMmethod = "limma",
#      FDRcritVal = 0.05,
#      core = 4,
#      sims = 50)
#  

## ----echo=FALSE, results='hide',message=FALSE---------------------------------
load("vignette_reduced.Rdata")

## ----example running pwrEWAS targetDelta time stamps, warning=FALSE, message=FALSE, eval=TRUE----
## [2019-02-12 18:40:23] Finding tau...done [2019-02-12 18:42:53]
## [1] "The following taus were chosen: 0.00390625, 0.02734375, 0.0390625, 0.052734375"
## [2019-02-12 18:42:53] Running simulation
## |===================================================================| 100%
## [2019-02-12 18:42:53] Running simulation ... done [2019-02-12 19:27:03]

## ----example results_targetDelta str, warning=FALSE, message=FALSE, eval=TRUE----
attributes(results_targetDelta)
## $names
## [1] "meanPower" "powerArray" "deltaArray" "metric"

## ----example results_targetDeltaput mean power, warning=FALSE, message=FALSE, eval=TRUE----
dim(results_targetDelta$meanPower)
print(results_targetDelta$meanPower)

## ----example power plot, warning=FALSE, message=FALSE, eval=TRUE--------------
dim(results_targetDelta$powerArray) # simulations x sample sizes x effect sizes
pwrEWAS_powerPlot(results_targetDelta$powerArray, sd = FALSE)

## ----example max delta, warning=FALSE, message=FALSE, eval=FALSE--------------
#  # maximum value of simulated differences by target value
#  lapply(results_targetDelta$deltaArray, max)
#  ## $`0.02`
#  ## [1] 0.02095302
#  ##
#  ## $`0.1`
#  ## [1] 0.1265494
#  ##
#  ## $`0.15`
#  ## [1] 0.2045638
#  ##
#  ## $`0.2`
#  ## [1] 0.2458416
#  
#  # percentage of simulated differences to be within the target range
#  mean(results _ targetDelta$deltaArray[[1]] < 0.02)
#  ## [1] 0.9999999
#  mean(results _ targetDelta$deltaArray[[2]] < 0.10)
#  ## [1] 0.9998882
#  mean(results _ targetDelta$deltaArray[[3]] < 0.15)
#  ## [1] 0.9999386
#  mean(results _ targetDelta$deltaArray[[4]] < 0.20)
#  ## [1] 0.9999539

## ----example density plot, warning=FALSE, message=FALSE, eval=FALSE-----------
#  pwrEWAS_deltaDensity(results_targetDelta$deltaArray, detectionLimit = 0.01, sd = FALSE)

## ----example density plot w/o 0.02, warning=FALSE, message=FALSE, eval=FALSE----
#  temp <- results_targetDelta$deltaArray
#  temp[[1]] <- NULL
#  pwrEWAS_deltaDensity(temp, detectionLimit = 0.01, sd = FALSE)

## ----example metrics, warning=FALSE, message=FALSE, eval=TRUE-----------------
results_targetDelta$metric

## ----sessionInfo, results='asis', echo=TRUE-----------------------------------
toLatex(sessionInfo())


# test 1: DRC Kibumba women ----------------------------------------------------
power_kibumba <- pwrEWAS(minTotSampleSize = 50,
                               maxTotSampleSize = 100,
                               SampleSizeSteps = 5,
                               NcntPer = 0.5,
                               targetDelta = c(seq(from=0.01, to=0.1, by=0.01), 0.20, 0.3, 0.4, 0.5),
                               J = 3e5,
                               targetDmCpGs = 100,
                               tissueType = "Saliva",
                               detectionLimit = 0.01,
                               DMmethod = "limma",
                               FDRcritVal = 0.05,
                               core = 4,
                               sims = 100)

pwrEWAS_powerPlot(data = power_kibumba$powerArray, sd = TRUE)
pwrEWAS_deltaDensity(data = power_kibumba$deltaArray, detectionLimit = 0.01, sd = FALSE)

summary(power_kibumba)

# MethylAid (package) -----------------------------------------------------
## Deploy MethylAid App
require(methods)
require(shiny)
.libPaths("./Portable/R-3.4.4/library")
runApp("./Portable/shiny", launch.browser=TRUE)

## Deploy MethylAid App
## Load cusomer and background data.
require(MethylAid)
require(MethylAidData)
load("../../methylaid.Rdata")
exampleData <- data
data(exampleDataLarge)

##Deploy MethylAid App
MethylAid:::server(exampleData, thresholds = list(MU = 10, OP = 12, BS = 11.75, HC = 12.75, DP = 0.95), background=exampleDataLarge)    

## Deploy MethylAid App
MethylAid:::ui(exampleData)




# RnBeads (package) -------------------------------------------------------
# installation (also install the latex program Ghostscript)
# source("http://rnbeads.org/data/install.R")
library("RnBeads")
rnb.run.dj()

# TODO: data preparation is not working

target <- read.csv("targets_2019_11_15_corrected_genotype.csv", sep=";")
head(target)

targetFU <- target[target$phenotype_time1=="FU", ]
idat_gre <- target[target$phenotype_time1=="FU", "idat_Grn"]
idat_red <- target[target$phenotype_time1=="FU", "idat_Red"]
idats_FU <- c(idat_gre, idat_red)



