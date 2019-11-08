################################################################################
# TUTORIAL: Como checar os seus dados ?
#
# (soluções)
#
################################################################################

data("iris")
head(iris)

data("PlantGrowth")
head(PlantGrowth)

################################################################################
# Encontrar valores
################################################################################
## Para valores de comprimento de sépalas, 
## quais observacoes são superiores a 5 cm ?

# condicao
iris$Sepal.Length > 5 
# observacoes que obedecem a esta condicao: alternativa 1
iris[iris$Sepal.Length > 5,]
# observacoes que obedecem a esta condicao: alternativa 2
subset(iris, iris$Sepal.Length > 5)
# checar que as duas alternativas produzem o mesmo resultado
all.equal(iris[iris$Sepal.Length > 5,], 
          subset(iris, iris$Sepal.Length > 5))

## Para valores de comprimento de pépalas, 
## quais observacoes sao iguais a 1.5 ou inferiores a 1 cm ?

# condicao 1
iris$Petal.Length == 1.5
# condicao 2
iris$Petal.Length < 1 
# condicao 1 ou condicao 2
iris$Petal.Length == 1.5 | iris$Petal.Length < 1 
# observacoes que obedecem a esta condicao
iris[iris$Petal.Length == 1.5 | iris$Petal.Length < 1,]

## Que espécies tem largura da sépala exatamente igual a 3 ?

# condicao
iris$Sepal.Width == 3
# espécies de iris que obedecem a esta condicao
iris[iris$Sepal.Width == 3, "species"] #

## Existem observacoes incompletas ou faltantes ?
sum(is.na(iris))

################################################################################
# Sumarizar valores
################################################################################
## Qual é o valor de média, mediana, desvio e erro padrao para 
## comprimento de sépalas ?
x <- iris$Sepal.Length
x
mean(x)
median(x)
sd(x)
sd(x)/sqrt(length(x))

## Como obter valores de centro e dispersao para todos os dados ?
summary(iris)
apply(iris, 2, sd)
apply(iris, 2, function(x) {mean(as.numeric(x))})
apply(iris, 2, function(x) {
  list(mean(as.numeric(x)),
       sd(x)
       )
  }
  )

## Como tabelar os valores para especie ou tratamento nos dois conjuntos de dados?
## Nota: essas variáveis nao sao continuas, elas sao categoricas.

# tabela comun
table(iris$Species)
# tabela com proporcoes
prop.table(table(PlantGrowth$group))
# tabela com proporcoes, logo transformadas a porcentagens e arredondadas a 2 digitos
round(prop.table(table(PlantGrowth$group))*100, 2)

## Como calcular o valor total de massa para as plantas medidas em PlantGrowth ?
# o mesmo pode ser produzido usando as funcoes rowSums() e colSums()
sum(PlantGrowth[,"weight"])
sum(PlantGrowth[,1])

################################################################################
# Substituir valores
################################################################################
## A espécie descrita como setosa na verdade se chama ungulata, como mudar esses 
## valores no conjunto de dados ?

# poderia dar certo, mas tem um erro nela. qual?
iris[iris$Species == "setosa", "Species"] <- "ungulata"
# Bom, vamos recarregar os dados e fazer de uma maneira diferente
data("iris")
# criar um vetor para produzir os valores corretos
x <- as.character(iris$Species)
# substituir valores
x[x == "setosa"] <- "ungulata"
# criar nova variavel dentro do conjunto de dados
iris$SpeciesUpdated <- x
# limpar o ambiente de trabalho/conjunto de dados
rm(x)
#iris$Species <- NULL

## Em PlantGrowth, assumimos que valores de massa inferiores a 4.5 sao impossiveis,
## como corrigir isso nos dados ? Todos valores iguais ou inferiores a 4.5 devem
## ser dados faltantes

# condicao
PlantGrowth$weight < 4.5 | PlantGrowth$weight == 4.5
# condicao: maneira mais resumida
PlantGrowth$weight <= 4.5
# checar que as duas alternativas produzem o mesmo resultado
identical(PlantGrowth$weight < 4.5 | PlantGrowth$weight == 4.5,
          PlantGrowth$weight <= 4.5)
# substituir valores no conjunto de dados
PlantGrowth[PlantGrowth$weight <= 4.5, "weight"] <- NA
PlantGrowth$weight

################################################################################
# Calcular valores
################################################################################
## Como calcular o tamanho proporcional de sepálas (comprimento/largura) ?
iris$Sepal.Length / iris$Sepal.Width
iris$Sepal.Proportion <- iris$Sepal.Length / iris$Sepal.Width
iris$Sepal.Proportion

## Como transformar a largura de pétalas para raiz quadrada, 
## log natural ou exponencial
sqrt(iris$Petal.Width)
log(iris$Petal.Width)
exp(iris$Petal.Width)

## Como calcular a soma de valores por colunas ou linhas
apply(iris[,c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")], 1, sum)
rowSums(iris[,1:4])

apply(iris[,1:4], 2, sum)
colSums(iris[,1:4])

################################################################################
# Repartir dados
################################################################################
## Como separar dados por espécies ?

# exemplo usando uma funcao
subset(iris, SpeciesUpdated == "ungulata")
# exemplo usando indexagem
iris[iris$SpeciesUpdated == "ungulata", ]

## Como separar dados por massa de plantas em três grupos 
## com mesmo numero de observacoes ?

index <- PlantGrowth$weight
plantas_leve <- PlantGrowth[index == 1, ]
plantas_medio <- PlantGrowth[index == 2, ]
plantas_pesado <- PlantGrowth[index == 3, ]

################################################################################
# Repetir tarefas
################################################################################
## Loops

for (i in 1:5) {
  print(i)
}

## Repetir tarefas sobre listas ou tabelas

apply(array, margin, ...)
apply(iris[,1:4], 2, log1p)

lapply(list, function)
sapply(list, function)
