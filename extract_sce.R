# extracting data from single cell experiment object */
# BiocManager::install("scRNAseq")
library(scRNAseq)

# creates sce object
sce <- ReprocessedFluidigmData()
# see info
View(sce)
# get assay names, measurements of counts or normalized counts
a<-assayNames(sce)  
# pull out count data
Pollendata <- assays(sce, "rsem_counts",withDimnames = FALSE)
# sum data
libsizes <- colSums(Pollendata$rsem_counts)
#libsizes <- colSums(counts)
# grab metadata to pull out the High coverage data only
Pollenmeta <- colData(sce, "rsem_counts")
Coverage <- Pollenmeta$Coverage_Type # pull out coverage type data
High_index <- Coverage =="High"
Biocond <- Pollenmeta$Biological_Condition
Biocond[High_index]
High_counts <-Pollendata$rsem_counts[,High_index]
data2 <-High_counts
data_zero <- data2[apply(data2, 1, function(row) all(row !=0 )), ]
data3 <-t(data_zero)
### PCA--------------------------------------------------------------------------------
library("M3C")
library("factoextra")
library("FactoMineR")
#library(data.table)


data3.pr <- prcomp(data3, center = TRUE, scale = TRUE)
#data3.pr <- prcomp(data3[c(1:65)], center = TRUE, scale = TRUE)
summary(data3.pr)
res.pca <- PCA(data3, graph = TRUE)
eig.val <- get_eigenvalue(res.pca)
eig.val

# screeplot
fviz_eig(res.pca, addlabels = TRUE,ylim = c(0, 20),ncp = 10)

cumpro <- cumsum(data3.pr$sdev^2 / sum(data3.pr$sdev^2))
plot(cumpro[0:30], xlab = "PC #", ylab = "Amount of explained variance", main = "Cumulative variance plot")
abline(v = 6, col="blue", lty=5)
abline(h = 0.88759, col="blue", lty=5)
legend("topleft", legend=c("Cut-off @ PC6"),
       col=c("blue"), lty=5, cex=0.6)

# ELLIPSES
# plots PCs 1 and 2 labelled
# plot with ellipses

plot(data3.pr$x[,1],data3.pr$x[,2], 
     xlab="PC1 (18.58%)", 
     ylab = "PC2 (9.25%)", 
     main = "PC1 / PC2 - plot")

fviz_pca_ind(data3.pr, geom.ind = "point", pointshape = 21,
             pointsize = 2,
             fill.ind = Biocond_High,
             col.ind = "black",
             palette = "jco",
             addEllipses = TRUE,
             label = "var",
             col.var = "black",
             repel = TRUE,
             legend.title = "Biocond") +
 # ggtitle("2D PCA-plot from 30 feature dataset") +
  theme(plot.title = element_text(hjust = 0.5))

### tsne--------------------------------------------------------------------------------
#perplexity = 21 max

library("Rtsne")
tsne_out2<- Rtsne(data3,dims = 2, initial_dims = 30,perplexity = 10, theta = 0.5, check_duplicates = TRUE,
                  pca = TRUE, partial_pca = FALSE, max_iter = 5000,
                  verbose = getOption("verbose", FALSE), is_distance = FALSE,
                  Y_init = NULL, pca_center = TRUE, pca_scale = FALSE,
                  normalize = TRUE, stop_lying_iter = 250, 
                  mom_switch_iter = 250,
                  momentum = 0.5, final_momentum = 0.8, eta = 200,
                  exaggeration_factor = 12)
plot(tsne_out2$Y,
     col=as.factor(Biocond_High),
     asp=1) # Plot the result


legend("bottomright", legend = paste("Group", 1:4), col = 1:4, pch = 19, bty = "n")


### UMAP---------------------------------------------------------------------------------
#install.packages("umap")
#library("umap")
umap(t(data3),
     #n_neighbors = 10,
     #min_dist = 0.8,
     #colvec=c('skyblue'),
     labels=as.factor(Biocond_High),
     controlscale=TRUE,scale=3,
     dotsize = 3
     )





