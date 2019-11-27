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

knnImplementation <- function(train, test, classesTrain) {
  k.optm = 1
  
  for (i in 1:15){
    knn.mod <- knn(train = train, test=test, cl=classesTrain, k=i)
    
    print(confusionMatrix(knn.mod, classesTest))
    
    k.optm[i] <- 100 * sum(classesTest == knn.mod)/NROW(classesTest)
    k=i
    cat(k, '=', k.optm[i], '')
  }
  
  
  plot(k.optm, type="b", xlab="Valor de K", ylab="Nível de Acurácia")
  
  return(k.optm)
}

#############################################################################

# Execute the function 
knnImplementation(train, test, classesTrain)

#############################################################################

# SVM

install.packages("e1071")
library(e1071)

svmImplementation = function(train, test, classesTest) {
  classificadorSVM = svm(
    formula = classe~ .,
    data = train,
    type = 'C-classification',
    kernel = 'linear')
  
  predictSVM = predict(classificadorSVM, newdata = test)
  
  confusionMatrix(predictSVM, classesTest)
}

#############################################################################

trainSVM <- trainBackup
testSVM <- test
classesTestSVM <- classesTest

# Execute the function 
svmImplementation(trainSVM, testSVM, classesTestSVM)

trainSVM <- NULL
testSVM <- NULL
classesTestSVM <- NULL

#############################################################################

# Tree

install.packages("rpart")
install.packages("rpart.plot")

library(rpart)
library(rpart.plot)

treeImplementation <- function(train, test, classesTest) {
  modeloTree <- rpart(
    formula = classe~.,
    data = train,
    method = "class",
    control = rpart.control(minsplit = 1))
  
  predictTree <- predict(modeloTree, test, type = "class")
  
  confusionMatrix(predictTree, classesTest) 
}

#############################################################################

trainTREE <- trainBackup
testTREE <- test
classesTestTREE <- classesTest

# Execute the function 
treeImplementation(trainTREE, testTREE, classesTestTREE)

trainTREE <- NULL
testTREE <- NULL
classesTestTREE <- NULL


#############################################################################

# Elbow

elbowImplementation <- function(dataFrame) {
  wss <- (nrow(dataFrame) - 1) * sum(apply(dataFrame, 2, var))
  
  for (i in 2:20) {
    wss[i] <- sum(kmeans(dataFrame, centers=i)$withinss)
  }
  
  plot(1:20, wss, type="b", xlab="Número de Clusters")  
}

#############################################################################

# Execute the function 
elbowImplementation(dataFrame)

#############################################################################

# K-means
install.packages("factoextra")

library(cluster)
library(factoextra)

kmeansImplementation <- function(dataFrameCluster) {
  resultKMeans <- kmeans(dataFrameCluster, 10)
  
  table(resultKMeans$cluster, dataFrame$classe)
}

#############################################################################

dataFrameCluster <- dataFrame[,-4097]

# Execute the function
kmeansImplementation(dataFrameCluster)

#############################################################################

# PCA
dataframePCA <- dataFrame[,1:4096]

dataframePCA <- prcomp(dataframePCA, center = TRUE, scale. = TRUE)

# Dimensons
fviz_eig(dataframePCA)

# Dataset
newDataframePCA <- as.data.frame(predict(dataframePCA, dataFrame))
newDataframePCA$classe <- dataFrame$classe # Add classes

# Separete dataset 
indexesPCA <- sample(1:nrow(newDataframePCA), as.integer(0.8 * nrow(newDataframePCA)))

trainPCA <- newDataframePCA[indexesPCA, ]
trainPCABackup <- trainPCA
trainPCAClasses <- trainPCA$classe

testPCA <- newDataframePCA[-indexesPCA, ]
testPCAClasses <- factor(testPCA$classe)

testPCA$classe <- NULL
trainPCA$classe <- NULL


# Implementations with PCA:

# KNN
knnImplementation(trainPCA, testPCA, trainPCAClasses)

# SVM
trainTREESVM <- trainPCABackup
svmImplementation(trainTREESVM, testPCA, testPCAClasses)

trainTREESVM <- NULL

# TREE 
trainTREEPCA <- trainPCABackup
treeImplementation(trainTREEPCA, testPCA, testPCAClasses)

trainTREEPCA <- NULL

# Elbow
elbowImplementation(newDataframePCA)

# K-Means
kmeansImplementation(newDataframePCA)

#############################################################################

