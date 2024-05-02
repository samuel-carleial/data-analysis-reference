#-------------------------------------------------------------------------------
# EXERCISES (ANSWERS) ----------------------------------------------------------
#-------------------------------------------------------------------------------

library("lavaan")
library("semPlot")

#- TASK 1 ----------------------------------------------------------------------
# (5 min)

# (EN) using the "FacialBurns" dataset, evaluate whether sex difference
# affect facial burns ("Total Burned Surface Area" = TBSA) in patients with mental 
# disorders. TBSA is explained by a latent variable made out of self-esteem and HADS.
# Also, control your model for age.

# (PT) use o conjunto de dados "FacialBurns" para avaliar se a diferença de sexo
# afeta queimaduras faciais ("Total Burned Surface Area" = TBSA) em pacientes 
# com transtornos mentais. TBSA é uma medida que pode ser explicada por auto-estima 
# ("self-esteem) e HADS (escala psicológica), como uma variável latente. 
# Controle seu modelo com a variável idade.

data("FacialBurns") 
help(FacialBurns)
tibble(FacialBurns)


model <- 
  ' 
    # measurement
    psych =~ Selfesteem + HADS
    
    # regressions
    TBSA  ~ Sex + Age + psych
'

fit <- cfa(model, data = FacialBurns)
summary(fit, fit.measures = TRUE)
semPaths(fit)
rm(model, fit)


#- TASK 2 ----------------------------------------------------------------------
# (5 min)

# (EN) use the classical "HolzingerSwineford1939" dataset to produce a path 
# model of three latent factors of mental ability (visual, textual and speed).
# The latent variables should explain grade scores. Add control variables as age
# and sex into the model. See help("<dataset>") for more detail.

# (PT) use o conjunto de dados "HolzingerSwineford1939" para produzir um modelo 
# de análise de caminhos contendo três variáveis latentes de capacidade mental 
# (visual, textual e velocidade). As variáveis latentes devem explicar as pontuações 
# em diferentes disciplinas. Adicione variáveis de controle como idade e sexo no modelo.
# Ver help("<dataset>") para mais detalhes do conjunto de dados.

data("HolzingerSwineford1939")
help(HolzingerSwineford1939)

model <- 
' 
    # measurement
    visual  =~ x1 + x2 + x3
    textual =~ x4 + x5 + x6
    speed   =~ x7 + x8 + x9
    
    # regressions
    visual  ~ ageyr + sex
'

fit <- cfa(model, data = HolzingerSwineford1939)
summary(fit, fit.measures = TRUE)
semPaths(fit)
rm(model, fit)


#- TASK 3 ----------------------------------------------------------------------
# (10 min)

# (EN)
# - Suggest a dataset from your own or from a public repository
# - Define a hypothesis
# - Specify and identify your model
# - After reaching a final model, report your progress in detail
# - Present and interpret your diagram
# - Enlist your difficulties, problems and mistakes

# (PT)
# - Sugira um conjunto de dados ou use um de um repositório público
# - Defina uma hipótese
# - Especifique e identifique o seu modelo
# - Relate o seu progresso e resultado
# - Apresente e interprete o seu diagrama
# - Aliste suas dificuldades, problemas e erros


#- END -------------------------------------------------------------------------
# MY NOTES:
#
#
#
#
