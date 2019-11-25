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
trainBackup <- train


test <- dataFrame[-indexes, ]

classesTrain <- train$classe
classesTest <- factor(test$classe) 

test$classe <- NULL
train$classe <- NULL

#############################################################################

# KNN

install.packages("caret")

library(lattice)
library(caret)
library(class)

# Acuracia
acuracia <- vector()

# KNN implementations:
k.optm = 1

for (i in 1:15){
  knn.mod <- knn(train = train, test=test, cl=classesTrain, k=i)

  print(confusionMatrix(knn.mod, classesTest))
  
  k.optm[i] <- 100 * sum(classesTest == knn.mod)/NROW(classesTest)
  k=i
  cat(k, '=', k.optm[i], '')
}


plot(k.optm, type="b", xlab="Valor de K", ylab="Nível de Acurácia")


#############################################################################

# SVM

install.packages("e1071")
library(e1071)

trainSVM <- trainBackup

classificadorSVM = svm(
                    formula = classe~ .,
                    data = trainSVM,
                    type = 'C-classification',
                    kernel = 'linear')

predictSVM = predict(classificadorSVM, newdata = test)

confusionMatrix(predictSVM, classesTest)


#############################################################################

# Tree

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

# K-means
install.packages("factoextra")

library(cluster)
library(factoextra)

dataFrameCluster <- dataFrame[,-4097]
resultKMeans <- kmeans(dataFrameCluster, 10)

fviz_cluster(resultKMeans,
             data = dataFrameCluster,
             ggtheme = theme_minimal(),
             main = "Partitioning Clustering Plot"
            )


#############################################################################


