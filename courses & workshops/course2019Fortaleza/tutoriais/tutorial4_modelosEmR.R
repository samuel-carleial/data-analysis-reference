################################################################################
# TUTORIAL 4: Modelos (lineares) estatísticos
################################################################################

set.seed(12345)

library("blmeco")
library("lme4")
library("nlme")
library("memisc")
library("vcd")
library("multcomp")
library("lsmeans")
library("effects")
library("ggplot2")
library("ggfortify")
library("GGally")
library("DHARMa")

source("../../../helpfulFunctions.R")


################################################################################
# (1) Modelo linear simples (Gaussian)
################################################################################

# carregar dados
data("chickwts")
# DICA: tente o mesmo usando outros dados, ie., data("PlantGrowth")
help(chickwts)

# ver dados
head(chickwts)

#ver variável resposta
hist(chickwts$weight)

# modelo linear
m1_glm <- glm(weight ~ feed, data = chickwts)
m1_aov <- aov(weight ~ feed, data = chickwts)

# estrutura dos modelos
names(m1_glm)
names(m1_aov)
str(m1_glm)
str(m1_aov)

m1_glm$method
m1_glm$coefficients

# resultado: sumário
summary(m1_glm)
summary(m1_aov)

# resultado: residuos
par(mfrow = c(2,2))
plot(m1_glm)
plot(m1_aov)

# resultado: critério de informação
AIC(m1_glm, m1_aov)

# contrastes
# usando pacote multcomp
summary(glht(m1_glm, linfct = mcp(feed = "Tukey"))) 
# usando pacote lsmeans
lsmeans(m1_glm, list(pairwise ~ feed), adjust = c("tukey"))


# Intervalos de confianca
# note que apenas a ultima racao foi nao significativa
summary(m1_glm)
confint(m1_glm)
confint(m1_aov)

levels(chickwts$feed)

# visualização de efeitos
plot(allEffects(m1_glm), main = "GLM")
plot(allEffects(m1_aov), main = "ANOVA")


################################################################################
# (2) Modelo linear simples (Poisson)
################################################################################

# carregar dados
data("OrchardSprays")
# DICA: tente o mesmo usando outros dados, ie., data("InsectSprays")
help("OrchardSprays")
tail(OrchardSprays)

# desenho experimental e variável resposta
par(mfrow = c(1,2))
plot(OrchardSprays$rowpos, OrchardSprays$colpos)
hist(OrchardSprays$decrease)

# para cada tratamento existe uma variável por coluna/linha
table(OrchardSprays[,2:4])

# goodness of fit para uma distribuicao tipo Poisson
fit2 <- goodfit(OrchardSprays$decrease, type = "poisson")
summary(fit2)
rootogram(fit2)

# modelo linear
m2_glm <- glm(decrease ~ treatment
              , family = "poisson"
              , data = OrchardSprays)

# sumário e diagnótico
par(mfrow = c(2,2))
summary(m2_glm)
plot(m2_glm)

# alternativa para o padrao R
autoplot(m2_glm, 
         which = 1:6, 
         label.size = 3, 
         data = OrchardSprays,
         colour = "treatment") +
  theme(legend.position = "none")

# modelo linear misto
m2_glmm <- glmer(decrease ~ 
                   treatment 
                 + (1|rowpos)
                 , family = "poisson"
                 , data = OrchardSprays)
summary(m2_glmm)
plot(m2_glmm)

# efeitos
plot(allEffects(m2_glm))


################################################################################
# (3) Modelo linear complexo (Poisson)
################################################################################

# carregar dados
data("Arabidopsis")
help("Arabidopsis")
head(Arabidopsis)

# visualização prévia
names(Arabidopsis)
dev.off()
hist(Arabidopsis$total.fruits)
ggpairs(Arabidopsis)

# goodness of fit
fit3 <- goodfit(Arabidopsis$total.fruits, type = "poisson")
summary(fit3)
rootogram(fit3)

# modelo linear
m3_glmer <- glmer(total.fruits ~ 
              + nutrient # nutriente
              + amd      # herbivoria
              + reg      # região de origem
              + (1|popu) # população
              + (1|rack) # posição no invernadeiro
              , family = "poisson"
              , data = Arabidopsis)

m3_glmer.nb <- glmer.nb(total.fruits ~ 
                + nutrient # nutriente
                + amd      # herbivoria
                + reg      # região de origem
                + (1|popu) # população
                + (1|rack) # posição no invernadeiro
                #, family = "poisson"
                , data = Arabidopsis)

# sumário e diagnótico
par(mfrow = c(2,2))
summary(m3_glmer)
summary(m3_glmer.nb)

# Nota: critério de informacao menor é mais preferido
AIC(m3_glmer, m3_glmer.nb)

dispersion_glmer(m3_glmer)
dispersion_glmer(m3_glmer.nb)
# OBS: O modelo com distribuição binomial negativa tem ajuste melhor

# plots para objetos glmer geralmente não são tão completos como para GLMs
# portanto, é preciso um pouco mais de trabalho manual
plot(m3_glmer)
plot(m3_glmer.nb)

# verificar os resíduos contra todos os preditores possíveis:
par(mfrow=c(3,3))
plot(resid(m3_glmer.nb) ~ Arabidopsis$reg)
plot(resid(m3_glmer.nb) ~ Arabidopsis$popu)
plot(resid(m3_glmer.nb) ~ Arabidopsis$gen)
plot(resid(m3_glmer.nb) ~ jitter(Arabidopsis$rack))
plot(resid(m3_glmer.nb) ~ jitter(Arabidopsis$nutrient))
plot(resid(m3_glmer.nb) ~ Arabidopsis$amd)
plot(resid(m3_glmer.nb) ~ Arabidopsis$status)
# OBS: nenhum padrão indesejado reconhecível (residuos se distribuem de maneira normal)

# efeitos
plot(allEffects(m3_glmer))
plot(allEffects(m3_glmer.nb))


################################################################################
# Binomial
################################################################################

# referência:
# https://en.wikibooks.org/wiki/R_Programming/Binomial_Models

# simular dados
preditor <- 1 + rnorm(1000, 1) 
preditor_beta <- -1  + (preditor * 1)
proba <- exp(preditor_beta)/(1 + exp(preditor_beta))
resposta <- ifelse(runif(1000, 0, 1) < proba,1,0)
table(resposta)
dados <- data.frame(resposta, preditor)
head(dados)

# produzir modelo
m4_glm <- glm(resposta ~ preditor 
              , family = binomial
              , data = dados)

# verificar modelo
summary(m4_glm)
confint(m4_glm)
names(m4_glm) 

# verificar modelo usando o pacote DHARMa
plot(simulateResiduals(m4_glm))

predict(m4_glm) # predição em escala linear
predict(m4_glm, type = "response") # predição de probabilidades

# verificar efeito
# manualmente
par(mfrow = c(1,2))
plot(jitter(resposta, .15) ~ preditor
     , main = "errado")
lines(preditor
      , predict(m4_glm, type = "response")
      , col = "red")

plot(jitter(resposta, .15) ~ preditor
     , main = "correto \n(ordem de predições)")
lines(sort(preditor)
      , predict(m4_glm, type = "response")[order(preditor)]
      , col = "red")

# usando o pacote effects
plot(allEffects(m4_glm))

data()

################################################################################

sessionInfo()
