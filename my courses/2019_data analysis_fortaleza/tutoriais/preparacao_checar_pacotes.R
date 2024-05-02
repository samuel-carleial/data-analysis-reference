# Checar pacotes:
checar <- sapply(pkgs <- c("blmeco", "lme4", "nlme", "memisc", "vcd", "multcomp",
                           "lsmeans", "effects", "ggplot2", "ggfortify", "GGally",
                           "DHARMa", "lattice", "RColorBrewer", "corrplot"),
                 function(x) {require(x, quietly = TRUE, character.only = TRUE)}
                 )
                
stopifnot(all(checar))

# Instalar pacotes faltantes:
install.packages(nome_do_pacote, dependencies = TRUE)