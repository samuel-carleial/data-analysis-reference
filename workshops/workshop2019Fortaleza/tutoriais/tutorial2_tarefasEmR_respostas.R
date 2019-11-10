################################################################################
# (com soluções) 
# TUTORIAL 2: Tarefas comuns e como checar dados em R ?
################################################################################

data("iris")
head(iris)

data("PlantGrowth")
head(PlantGrowth)

################################################################################
# Encontrar valores
################################################################################
## (1) Para valores de comprimento de sépalas, 
## quais observações são superiores a 5 cm ?
# condição
iris$Sepal.Length > 5 
# alternativa 1 (observações que obedecem a esta condição)
iris[iris$Sepal.Length > 5,]
# alternativa 2
subset(iris, iris$Sepal.Length > 5)
# checar que ambas alternativas produzem o mesmo resultado
all.equal(iris[iris$Sepal.Length > 5,], subset(iris, iris$Sepal.Length > 5))

## (2) Para valores de comprimento de pétalas, 
## quais observações são iguais a 1.5 ou inferiores a 1 cm ?
# condição 1
iris$Petal.Length == 1.5
# condição 2
iris$Petal.Length < 1 
# condição 1 ou condição 2
iris$Petal.Length == 1.5 | iris$Petal.Length < 1 
# observações que obedecem a esta condição
iris[iris$Petal.Length == 1.5 | iris$Petal.Length < 1,]

## (3) Que espécies têm largura de sépala exatamente igual a 3 ?
# condição
iris$Sepal.Width == 3
# espécies de iris que obedecem a esta condição
iris[iris$Sepal.Width == 3, "species"] # algo de errado aqui? Case-sensitive!

## (4) Existem observações incompletas ou faltantes ?
sum(is.na(iris))

################################################################################
# Sumarizar valores
################################################################################
## (5) Qual é o valor de média, mediana, desvio e erro padrão para 
## comprimento de sépalas ?
x <- iris$Sepal.Length
x
mean(x)
median(x)
sd(x)
sd(x)/sqrt(length(x))

## (6) Como obter valores de centro e dispersão para todos os dados ?
summary(iris)
apply(iris, 2, sd)
apply(iris, 2, function(x) {mean(as.numeric(x))})
apply(iris, 2, function(x) {
  list(mean(as.numeric(x)),
       sd(x)
       )
  }
  )

## (7) Como tabelar os valores para espécie ou tratamento nos dois conjuntos de dados?
## Nota: essas variáveis não são contínuas, elas são categóricas.
# tabela comun
table(iris$Species)
# tabela com proporções
prop.table(table(PlantGrowth$group))
# tabela com proporções, mas transformadas a porcentagens e arredondadas a 2 dígitos
round(prop.table(table(PlantGrowth$group))*100, 2)

## (8) Como calcular o valor total de massa para as plantas medidas em PlantGrowth ?
sum(PlantGrowth[,"weight"])
sum(PlantGrowth[,1])
# Nota: o mesmo pode ser produzido usando as funções rowSums() e colSums()
# mas essas funções requerem mais de uma coluna ou linha para funcionar

################################################################################
# Substituir valores
################################################################################
## (9) A espécie descrita como setosa na verdade se chama ungulata, como mudar
## isso no conjunto de dados ?
# trocar todos os valores de "setosa" por "ungulata"
# *poderia dar certo, mas tem um erro no código abaixo. Qual?
iris[iris$Species == "setosa", "Species"] <- "ungulata" #
# Bom, vamos recarregar os dados e fazer de uma maneira diferente
data("iris")
# criar um vetor para produzir os valores corretos
x <- as.character(iris$Species)
# substituir valores
x[x == "setosa"] <- "ungulata"
# criar nova variável dentro do conjunto de dados
iris$SpeciesUpdated <- x
# limpar o ambiente de trabalho/conjunto de dados
rm(x)
# para remover uma variável de um conjunto de dados usa-se NULL
iris$Species <- NULL
head(iris)

## (10) Em PlantGrowth, assumimos que valores de massa inferiores a 4.5 são irreais,
## como corrigir isso nos dados ? Todos valores iguais ou inferiores a 4.5 devem
## ser dados faltantes
# condição
PlantGrowth$weight < 4.5 | PlantGrowth$weight == 4.5
# condição: maneira mais resumida
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
## (11) Como calcular o tamanho proporcional de sepálas (comprimento/largura) ?
iris$Sepal.Length / iris$Sepal.Width
iris$Sepal.Proportion <- iris$Sepal.Length / iris$Sepal.Width
iris$Sepal.Proportion

## (12) Como transformar a largura de pétalas para raiz quadrada, 
## log natural e exponencial
sqrt(iris$Petal.Width)
log(iris$Petal.Width)
exp(iris$Petal.Width)

## (13) Como calcular a soma de valores por colunas ou linhas
# soma por linhas
apply(iris[,c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")], 1, sum)
rowSums(iris[,1:4])
# soma por colunas
apply(iris[,1:4], 2, sum)
colSums(iris[,1:4])

################################################################################
# Repartir dados
################################################################################
## (14) Como separar dados por espécies ?
# exemplo usando uma função
subset(iris, SpeciesUpdated == "ungulata")
# exemplo usando indexação
iris[iris$SpeciesUpdated == "ungulata", ]

## (15) Como separar dados de massa de plantas em três grupos que representem
## valores de peso em categorias ? PlantGrowth
categorias <- PlantGrowth$weight
categorias
categorias <- cut(categorias, breaks = 3, labels = c("leve", "medio", "pesado"))
categorias
PlantGrowth$categorias <- categorias
head(PlantGrowth)
table(PlantGrowth$categorias)

################################################################################
# Repetir tarefas
################################################################################
## (16) Loops: faça um exemplo simple de loop. 
## Caso queira tente resolver também o problema seguinte:
## Usando o conjunto de dados iris, crie um novo conjunto de dados chamado iris2
## onde cada valor deve ser substituido pelo seu tipo de variável, por exemplo:
## 1 deve ser numeric e "setosa" deve ser character.
# exemplo 1: como iterar por cinco elementos e mostrar cada valor separadamente
x <- LETTERS
x
for (i in seq_along(x)) {
  print(x[i])
}
# exemplo 2: caso sugerido
iris2 <- as.data.frame(matrix(NA, nrow = nrow(iris), ncol = ncol(iris)))
names(iris2) <- colnames(iris)
head(iris2)
for (linha in 1:nrow(iris)) {
  for (coluna in 1:ncol(iris)) {
    iris2[linha,coluna] <- class(iris[linha,coluna])
  }
}
head(iris2)

## (17) Repetir tarefas sobre listas ou tabelas
apply(array, margin, ...)
apply(iris[,1:4], 2, log1p)

lapply(list, function)
sapply(list, function)
