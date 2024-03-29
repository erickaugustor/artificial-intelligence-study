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

# Na classifica��o, Species s�o as classes, e o resto � para a constru��o da �rvore
# � importante dizer qual � a classe! Arvore n�o fala disso.
# Metodo � de classfica��o
# Qual o n�mero minimo de elementos que existe pra classificar

# Qual o numero? Grid search, coloca varios valores e ver qual � a melhr acur�cia


plot <- rpart.plot(modelo, type = 3)


classif <- test[,5] # Guardando a classifica��p
test <- test[,-5] # Removendo as classes
pred <- predict(modelo, test, type = "class")






