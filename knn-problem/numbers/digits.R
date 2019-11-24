library(tidyverse)
library(ggplot2)


locationFiles <- paste0(getwd(), '/files-numbers')
setwd(locationFiles)

filesList <- list.files(path = locationFiles)

dataFrame <- data.frame()
classe <- c()


#############################################################################

for(file in filesList) {
  classe <- c(classe, as.numeric(unlist(strsplit(file, "_"))[1]))
  contentFile <- read_lines(file)
  contentFile <- contentFile[-(1:3)] # Remove the first three lines
  
  contentFile <- unlist(strsplit(contentFile, " ")) # Break into spaces
  contentFile <- as.numeric(contentFile) # Transform to numbers

  dataFrame <- matrix(
    unlist(contentFile),
    nrow = nrow(dataFrame) + 1,
    ncol = length(contentFile)
  )
  dataFrame <- as.data.frame(dataFrame)
  dataFrame$classe <- classe
}

#############################################################################

# Separete dataframe in teste and train

indexes <- sample(1:nrow(dataFrame), as.integer(0.8 * nrow(dataFrame)))

train <- dataFrame[indexes, ]
test <- dataFrame[-indexes, ]

classesTrain <- train$classe
classesTest <- factor(test$classe) 

test$classe <- NULL


#############################################################################

# KNN

install.packages("caret")

library(lattice)
library(caret)


# Acuracia
acuracia <- vector()

# KNN implementations:
K1 <- knn(train, test, classesTrain, 1)
results <- as.data.frame(K1)
confusionMatrix(K1, classesTest)

K3 <- knn(train, test, classesTrain, 3)
results[,2] <- as.data.frame(K3)
confusionMatrix(K3, classesTest)

K7 <- knn(train, test, classesTrain, 7)
results[,3] <- as.data.frame(K7)
confusionMatrix(K7, classesTest)

K9 <- knn(train, test, classesTrain, 9)
results[,4] <- as.data.frame(K9)
confusionMatrix(K9, classesTest)

correctResults <- as.vector(dataFrame[-indexes, ncol(dataFrame)])
results[,5] <- as.data.frame(correctResults)


# Calculando acuracia
for (i in 1:ncol(results) - 1) {
  tabela <- table(results[,i] == results[,5])
  qtdTrue <- tab[names(tab) == TRUE]
  
  acuracia[i] <- qtdTrue/nrow(results)
  
  tabela <- NA
  qtdTrue <- NA
}


#############################################################################

# SVM

install.packages("e1071")
library(e1071)

classificadorSVM = svm(
                    formula = classe~ .,
                    data = train,
                    type = 'C-classification',
                    kernel = 'linear')

predictSVM = predict(classificadorSVM, newdata = test)

confusionMatrix(predictSVM, classesTest)


#############################################################################

install.packages("rpart")
install.packages("rpart.plot")

library(rpart)
library(rpart.plot)

modeloTree <- rpart(
                    formula = classe~.,
                    data = train,
                    method = "class",
                    control = rpart.control(minsplit = 1))

plot <- rpart.plot(modeloTree, type = 3)

predictTree <- predict(modeloTree, test, type = "class")

confusionMatrix(predictTree, classesTest)


#############################################################################

# Elbow

wss <- (nrow(dataFrame) - 1) * sum(apply(dataFrame, 2, var))

for (i in 2:20) {
  wss[i] <- sum(kmeans(dataFrame, centers=i)$withinss)
}

plot(1:20, wss, type="b", xlab="Número de Clusters")

#############################################################################
