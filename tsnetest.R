# Requires package Rtsne

#install.packages("Rtsne") # Install Rtsne package from CRAN
library("Rtsne")
# read in Breast Cancer data set from UCI Machine Learning
wdbc <- read.csv("wdbc.data", header = F,stringsAsFactors = T)

# assign feature names to data
features <- c("radius", "texture", "perimeter", "area",
              "smoothness", "compactness", "concavity", 
              "concave_points", "symmetry", "fractal_dimension")
names(wdbc) <- c("id", "diagnosis", paste0(features,"_mean"),
                 paste0(features,"_se"), paste0(features,"_worst"))
# exploratory data analysis
head(wdbc)
pairs(wdbc[,3:12], pch = 19)
my_cols <- c("#00AFBB", "#E7B800")  
pairs(wdbc[,3:12], pch = 19,  cex = 0.5,
      col = my_cols[wdbc$diagnosis],
      lower.panel=NULL)

# run tsne on data
tsne_out <- Rtsne(wdbc[c(3:32)],dims = 2, initial_dims = 30,perplexity = 30, theta = 0.5, check_duplicates = TRUE,
      pca = TRUE, partial_pca = FALSE, max_iter = 5000,
      verbose = getOption("verbose", FALSE), is_distance = FALSE,
      Y_init = NULL, pca_center = TRUE, pca_scale = FALSE,
      normalize = TRUE, stop_lying_iter = 250, 
      mom_switch_iter = 250,
      momentum = 0.5, final_momentum = 0.8, eta = 200,
      exaggeration_factor = 12)
plot(tsne_out$Y,col=wdbc$diagnosis,asp=1) # Plot the result