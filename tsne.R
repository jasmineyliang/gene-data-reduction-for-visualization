# Requires package Rtsne

#install.packages("Rtsne") # Install Rtsne package from CRAN
library("Rtsne")
# read data
library("M3C")
#install.packages("data.table")
library(data.table)

data <- transpose(mydata)


# run tsne on data
tsne_out <- Rtsne(data[c(1:1740)],dims = 2, initial_dims = 30,perplexity = 10, theta = 0.5, check_duplicates = TRUE,
                  pca = TRUE, partial_pca = FALSE, max_iter = 5000,
                  verbose = getOption("verbose", FALSE), is_distance = FALSE,
                  Y_init = NULL, pca_center = TRUE, pca_scale = FALSE,
                  normalize = TRUE, stop_lying_iter = 250, 
                  mom_switch_iter = 250,
                  momentum = 0.5, final_momentum = 0.8, eta = 200,
                  exaggeration_factor = 12)
plot(tsne_out$Y,
     col=as.factor(annot[,1]),
     asp=1) # Plot the result


legend("bottomright", legend = paste("Group", 1:4), col = 1:4, pch = 19, bty = "n")

umap(t(data),
     #labels=as.factor(annot[,1]),
     controlscale=TRUE,scale=3,
     dotsize = 3,
     colvec=c('skyblue')
     )

