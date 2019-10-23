install.packages("rpart")
install.packages("rpart.plot")

library(rpart)
library(rpart.plot)

data <- iris
data

set.seed(123)


smp_size <- floor(0.8 * nrow(data)) # 80% pra treino
train_ind <- sample(seq_len(nrow(data)), size = smp_size) # Separa linha de treino

train <- data[train_ind,] # Pega as linhas separadas e monta um data.frame
test <- data[-train_ind,]

modelo <- rpart(
  Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width,
  train,
  method = "class",
  control = rpart.control(minsplit = 1)
)

# Na classificação, Species são as classes, e o resto é para a construção da árvore
# É importante dizer qual é a classe! Arvore não fala disso.
# Metodo é de classficação
# Qual o número minimo de elementos que existe pra classificar

# Qual o numero? Grid search, coloca varios valores e ver qual é a melhr acurácia


plot <- rpart.plot(modelo, type = 3)


classif <- test[,5] # Guardando a classificaçãp
test <- test[,-5] # Removendo as classes
pred <- predict(modelo, test, type = "class")






