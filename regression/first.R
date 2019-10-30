# Como podemos descrever a relação entre as variáveis?
# A relaçao descrita pelo modelo é estaticamente significativa (ou é sorte)?
# Previsão: Até que ponto o modelo generaliza bem as observações?

# A altura da mulher influência no peso, mas não é determinante!
# Outros fatores influenciam.

# Expressar expectiativas sobre a variável dependente com as independentes

# Conjunto de treino ---> Modelo ---> h

# Primeiro é utilizado o algoritmo de Descida de Gradiente para Regressão Linear


library(ggplot2)

dataset <- cars

nrow(dataset)
ncol(dataset)

# Plots

plot(dataset)

# Plots with ggplot

ggplot(dataset) +
  geom_point(mapping = aes(x = speed, y = dist, color = "speed"))

# For training

index <- sample(1:nrow(dataset), as.integer(0.8 * nrow(dataset)))

train <- dataset[index, ]
test <- dataset[-index, ]

plot(train)
plot(test)

# Calculate the lm
lm = lm(dist~speed, data = train)

#Plot graph for the train with the lm
plot(train) + abline(lm)

#Plot graph for the test with the lm
plot(test) + abline(lm)
pred <- predict(lm, test)

plot(pred)



