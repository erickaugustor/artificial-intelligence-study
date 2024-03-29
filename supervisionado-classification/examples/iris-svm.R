install.packages("e1071")

# dados lineares, plota no plano 2D e � poss�vel observar
# utiliza interplanos pra separar os dados

# procura hiperplano - ele procura a reta �tima
# como encontrar a melhor reta?

# ele procura deixar uma reta com a maior margem poss�vel entre os dados
# se o problema fosse 3d, seria um plano.
# para problemas com n-dimens�es, � procurado hiperplanos

library(e1071)

data <- iris
data

smp_size <- floor(0.8 * nrow(data)) # 80% pra treino
train_ind <- sample(seq_len(nrow(data)), size = smp_size) # Separa linha de treino

train <- data[train_ind,] # Pega as linhas separadas e monta um data.frame
test <- data[-train_ind,]

testClass <- test[,5]
test <- test [,-5]

classifier = svm(
  formula = Species ~ .,
  data = train,
  type = 'C-classification',
  kernel = 'linear'
)

# formula est� simplificada com o ponto, o ponto representa o resto dos telementos
# estamos utilizando a classifica��o linear
# C-classification pq o svm soluciona diversos problemas na IA

y_pred = predict(classifier, newdata = test)
