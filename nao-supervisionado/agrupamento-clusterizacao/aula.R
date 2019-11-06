# Aprendizado não supervisionado!
# Agrupamento

# Temos features de exemplares, colocamos lado a lado para saber a sua similaridade

# Algortimo k-means
# Agrupa objetos com base nos seus atributos

data <- iris[,-5]
classes <- iris[,5]

kmeans(data, 3) # 3 clusters, ou seja, 3 grupos
