rm(list=ls())

# packages in R for randomization
# randomizeR
# randomizr
# cvrand
# caralloc 
# SeqAlloc
# randPack

# randomizeR --------------------------------------------------------------

library("randomizeR")

vignette(package = "randomizeR")
vignette("article", package = "randomizeR")
vignette("comparison-example", package = "randomizeR")

# 15 supported randomization procedures
?randPar

# experiment design
N <- 100
treatments <- c("TAU", "NET")
# sex <- c("male", "female")
# violence <- c("low", "medium", "large")

# randomization method: complete randomized procedure (CR)
params <- crPar(N, groups = treatments)
cr_test <- genSeq(params, seed=1707084777)
cr_test <- genSeq(params, r = 1000, seed = 123)
getRandList(cr_test)
plotSeq(cr_test, plotAllSeq = TRUE)

# randomization method: big stick design (BSD)
params <- bsdPar(20, mti=5, groups = treatments)
genSeq(params, seed=1707084777)
bsd_test <- genSeq(params, seed=52300)
bsd_test <- genSeq(params, r = 1000, seed = 123)
getRandList(bsd_test)
plotSeq(bsd_test, plotAllSeq = TRUE)


# ramdomizr ---------------------------------------------------------------

library("ramdomizr")

blocks <- rep(c("A","B","C"), times = c(50,100,200))
Z <- block_ra(blocks = blocks)
table(blocks, Z)

Z <- block_ra(blocks = blocks, prob = .3)
table(blocks, Z)

Z <- block_ra(blocks = blocks, block_prob = c(.1,.2,.3))
table(blocks, Z)

Z <- block_ra(blocks = blocks, m = 20)
table(blocks, Z)

Z <- block_ra(blocks = blocks, block_m = c(20,30,40))
table(blocks, Z)

block_m_each <- rbind(c(25,25),
                      c(50,50),
                      c(100,100))

Z <- block_ra(blocks = blocks, block_m_each = block_m_each)
table(blocks, Z)

block_m_each <- rbind(c(10,40),
                      c(30,70),
                      c(50,150))

Z <- block_ra(blocks = blocks, block_m_each = block_m_each,
              conditions = c("control", "treatment"))
table(blocks, Z)

# Multi-arm Designs
Z <- block_ra(blocks = blocks, num_arms = 3)
table(blocks, Z)

block_m_each <- rbind(c(10,20,20),
                      c(30,50,20),
                      c(50,75,75))
Z <- block_ra(blocks = blocks, block_m_each = block_m_each)
table(blocks, Z)

Z <- block_ra(blocks = blocks, block_m_each = block_m_each,
              conditions = c("control", "placebo", "treatment"))
table(blocks, Z)

Z <- block_ra(blocks = blocks, prob_each = c(.1,.1,.8))
table(blocks, Z)


# cvrand ------------------------------------------------------------------

# caralloc ----------------------------------------------------------------

# SeqAlloc ----------------------------------------------------------------

# randPack ----------------------------------------------------------------



