# PCA
# Análise exploratória de dados.

# Classificação, problema para verificar se os dados estão correlatos.

# O componente principal é uma variância de várias


# O dataset será transformado, os dados serão mudados em relação as coisas

dataset <- mtcars

dataset.pca <- prcomp(dataset[,c(1:7, 10, 11)], center = TRUE, scale = TRUE)
# Calculando o valor da PCA, indicando as colunas de 1 a 7, coluna 10 e 11.
# center e scale, o scale diz respeito a padronização dos valores
# É preciso normalizar os dados pois o PCA é sensivel ao valor da escala

summary(dataset.pca)
# Sumarização dele mostra que existem 9 componentes principais, 9 colunas!
# As duas ultimas linhas mostra que o PC1 mostra que 62% do dataset existe uma classificação
# O PC2 tem 23%, que somado ao anterior chega com 85% de consideração

# O PC3 e adiante contribuem menos com o role, pois eles estão dispersos.

install.packages("factoextra")
library(factoextra)


fviz_eig(dataset.pca)
fviz_pca_ind(dataset.pca, col.ind = "black", rapel = TRUE)
# rapel nã deixa text overlapping
# Indices do PCA - Eixo PC1 e PC2

# Transformação linear, deslocou para a nova transformação

fviz_pca_var(dataset.pca,
             col.var ="contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE)

# Eixo X e eixo Y - X = PC1
# Iversamente proporcional cvl e mpg

fviz_pca_biplot(dataset.pca,
                rapel = TRUE,
                col.var = "#2E9FDF",
                col.ind = "#696969")





