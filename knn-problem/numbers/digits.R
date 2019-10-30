library(tidyverse)

location <- getwd()
# locationFiles <- paste0(getwd(), '/files-numbers')
setwd(location)

files <- list.files(path = location)

newDataFrame <- data.frame()


# Need tidyverse for the read_lines
completeFile <- read_lines(files[1])
completeFile <- completeFile[-(1:3)] # Remove the first three lines

pieces <- unlist(strsplit(completeFile, " ")) # Beak into spaces
pieces <- as.numeric(pieces) # transform to numbers

length(pieces)

newDataFrame <- matrix(unlist(pieces), nrow = nrow(newDataFrame) + 1, ncol = 4096)



















df<- data.frame(matrix(nrow=0, ncol=4097, byrow=T))

i <- 0
for(arquivo in arquivos){
  i <- i +1
  print(paste('Processando arquivo ',i,' de ', length(arquivos)))
  row <- nrow(df) + 1
  tempCsv <- read.csv(paste(diretorio, arquivo, sep=''))
  tipo <- unlist(strsplit(arquivo, '_'))[1]
  tempCsv <- tempCsv[-1:-2,]
  
  colunasString <- unlist(strsplit(as.character(tempCsv), " "))
  colunasString <- c(colunasString, tipo)
  
  df<- matrix(unlist(colunasString), nrow = row, ncol = 4097)
}

df <- as.data.frame(df)

df
