###########################################################################
### Check packages
###########################################################################

setseed(233562)

# Check packages
checar <- sapply(pkgs <- c("blmeco", "lme4", "nlme", "memisc", "vcd"),
                 function(x) {require(x, quietly = TRUE, character.only = TRUE)}
)

# Control
stopifnot(all(checar))

# Install missing ones
install.packages(package_name, dependencies = TRUE)

# Install missing ones (Bioconductor)
BiocManager::install()

# Check specific package
library()
citation()
help()
vignette()
demo()


###########################################################################

sessionInfo()
