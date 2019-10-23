location <- getwd()
locationFiles <- paste0(getwd(), '/file-numbers')

setwd(location)



arquivos <- list.files(locationFiles, pattern = '/file-numbers/*BMP.inv.pgm')













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
