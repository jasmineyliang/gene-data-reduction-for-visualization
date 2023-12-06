# gene-data-reduction-for-visualization
1. The first data set is a small set in M3C from:
Verhaak, Roel GW, et al. "Integrated genomic analysis identifies clinically relevant subtypes of glioblastoma characterized by abnormalities in PDGFRA, IDH1, EGFR, and NF1." Cancer cell 17.1 (2010): 98-110.
It has 50 data points and 1740 features. The goal is to separate the different glioblastoma subtypes using three common visualization views, PCA, t-SNE and UMAP.
Use the annotation data to color the points in final picture.

For each case, given the relevant parameters, scree plot for PCA, perplexity for t-SNE, etc. For UMAP and t-SNE, and some different parameter combinations.

Discuss the results.

2. The second data set is an older scRNAseq data set from the Bioconductor package scRNAseq. Perform the same analysis as in part 1.
The paper citation is provided below.
Pollen, Nowakowski, Shuga, Wang, Leyrat, Lui, Li, Szpankowski, Fowler, Chen, Ramalingam, Sun, Thu, Norris, Lebofsky, Toppani, Kemp II, Wong, Clerkson, Jones, Wu, Knutsson, Alvarado, Wang, Weaver, May, Jones, Unger, Kriegstein, West. Low-coverage single-cell mRNA sequenc- ing reveals cellular heterogeneity and activated signaling pathways in developing cerebral cortex. Nature Biotechnology, 32, 1053-1058 (2014).
The associated Rdata object has the RSEM count data for the high coverage experiments and the gene names and biological condition. Filtered the data and then take the log before doing the dimension reduction. See the online version of the paper in methods.
“Transcripts with TPM values less than 1 were dropped from further analysis before log transformation. To identify outlier cells from each chip, we considered a set of genes detected in at least half of the samples, and samples with median expression values below the 15th percentile for these genes were removed using the identifyOutliers function in the SINGuLAR package. No additional “
