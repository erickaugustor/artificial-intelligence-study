dataset <- iris

dataset.pca <- prcomp(dataset[,1:4], center = TRUE, scale = TRUE)

summary(dataset.pca)

install.packages("factoextra")
library(factoextra)


fviz_eig(dataset.pca)

fviz_pca_ind(dataset.pca,
             geom.ind = "point",
             pointshape = 21,
             pointsize = 2,
             col.ind = "black",
             palette = "jco",
             addEllipses = TRUE,
             label = "var",
             cor.var = "black",
             fill.ind = dataset[,5],
             rapel = TRUE)


fviz_pca_var(dataset.pca,
             col.var = "contrib", # Color by contributions to the PC
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)

fviz_pca_biplot(dataset.pca, geom.ind = "point", pointshape = 21,
                pointsize = 2, 
                col.ind = "black", # Color by the quality of representation
                palette = "jco", 
                repel=TRUE,# Avoid text overlapping
                addEllipses = TRUE,
                label = "var",
                #                
                fill.ind = iris[,5],
                col.var = "contrib", # Color by contributions to the PC
                gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07")
                
)





