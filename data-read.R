#install.packages("BiocManager")
#BiocManager::install("M3C")
library("M3C")
library("factoextra")
library("FactoMineR")
library(data.table)
data <- mydata
data <- transpose(mydata)
annot <- desx
data.pr <- prcomp(data[c(1:50)], center = TRUE, scale = TRUE)
summary(data.pr)
#res.pca <- PCA(data[c(1:1740)], graph = TRUE)
res.pca <- PCA(data, graph = TRUE)

eig.val <- get_eigenvalue(res.pca)

# screeplot
fviz_eig(res.pca, addlabels = TRUE,ylim = c(0, 30),ncp = 10)

cumpro <- cumsum(data.pr$sdev^2 / sum(data.pr$sdev^2))
plot(cumpro[0:30], xlab = "PC #", ylab = "Amount of explained variance", main = "Cumulative variance plot")
abline(v = 6, col="blue", lty=5)
abline(h = 0.88759, col="blue", lty=5)
legend("topleft", legend=c("Cut-off @ PC6"),
       col=c("blue"), lty=5, cex=0.6)

# ELLIPSES ----------------------------------------------------------------
# plots PCs 1 and 2 labelled
# plot with ellipses

plot(data.pr$x[,1],data.pr$x[,2], xlab="PC1 (21.2%)", ylab = "PC2 (9.6%)", main = "PC1 / PC2 - plot")
fviz_pca_ind(data.pr, geom.ind = "point", pointshape = 21,
             pointsize = 2,
             fill.ind = annot$class,
             col.ind = "black",
             palette = "jco",
             addEllipses = TRUE,
             label = "var",
             col.var = "black",
             repel = TRUE,
             legend.title = "Diagnosis") +
#  ggtitle("2D PCA-plot from 30 feature dataset") +
  theme(plot.title = element_text(hjust = 0.5))





