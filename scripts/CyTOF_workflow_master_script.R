#------------------------------------------------------------
# Script started by Felix J. Hartmann (Inst. Experimental 
# Immunology @UZH), heavily modified by Mark Robinson 
# and Lukas Weber, IMLS @ UZH
#------------------------------------------------------------


#------------------------------------------------------------
# install packages if needed (skip if already setup)
#------------------------------------------------------------
source("http://bioconductor.org/biocLite.R")
biocLite(c("readxl", "flowCore", "ggplot2", "Rtsne", 
           "dplyr", "FlowSOM","pheatmap", "reshape2"))


#------------------------------------------------------------
# load packages, set working directory
#------------------------------------------------------------
setwd("~/projects/cytof/teaching")
library(readxl)
library(flowCore)  
library(ggplot2)
library(Rtsne)
library(dplyr)
library(FlowSOM)
library(pheatmap)
library(reshape2)

#------------------------------------------------------------
# read in metadata
#------------------------------------------------------------
md <- read_excel("data/metadata.xlsx")
md
class(md)



#------------------------------------------------------------
# read in flow/mass cytometry data FCS files
#------------------------------------------------------------
fs  <- read.flowSet(files=md$filename, path = "data/BodenmillerEtAl2012_BCRXL")
fs



# exploring flowSets
class(fs)
sampleNames(fs)
colnames(fs)
fsApply(fs,nrow)
fs[[16]]
ff <- fs[[16]]
ff
class(ff)


# exploring flowFrames
e <- exprs(ff)
dim(e)
head(e)
class(e)


#------------------------------------------------------------
# basic plot: # of cells per sample w/ ggplot2
#------------------------------------------------------------
md$ncells <- fsApply(fs,nrow)[,1]

ggplot(md, aes(x=shortname,y=ncells,color=condition)) + 
  geom_bar(size=2, stat = "identity", width=0.5) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


#------------------------------------------------------------
# basic plot: scatter plots with base R
#------------------------------------------------------------
plot( e[,"DNA-1(Ir191)Dd"], e[,"DNA-2(Ir193)Dd"] )
plot( asinh(e[,"DNA-1(Ir191)Dd"]/5), asinh(e[,"DNA-2(Ir193)Dd"]/5) )
smoothScatter( asinh(e[,"DNA-1(Ir191)Dd"]/5), asinh(e[,"DNA-2(Ir193)Dd"]/5) )


# combine data into a matrix
d <- fsApply(fs, exprs)
head(d)
dim(d)
dtrans <- asinh(d/5)



#------------------------------------------------------------
# example aggregation using stats::aggregate()
#------------------------------------------------------------
samp <- rep(md$shortname, md$ncells)
dim(dtrans)
length(samp)
marker_cols <- c(3:4, 9, 11,12,14, 21, 29, 31, 33)

medians_agg <- aggregate(dtrans[,marker_cols], 
                         by=list(samp), FUN=median)

medians_agg1 <- data.frame(medians_agg[,-1], 
                           row.names=medians_agg[,1])


#------------------------------------------------------------
# example aggregation using dplyr pipes
#------------------------------------------------------------
df <- data.frame(dtrans[,marker_cols], samp=samp)


# pipes
df %>% nrow()                   # same as nrow(df)
df %>% colnames() %>% length()  # same as length(colnames(df))

medians_se <- df %>%
                group_by(samp) %>% 
                summarize_each(funs(median,mean))

# summarize_each(group_by(df, samp),funs(median))

medians_se1 <- data.frame(medians_se[,-1], 
                          row.names=medians_se$samp)
                          
                          
# check that medians_se1 and medians_agg1 give the same result
medians_se1[1:3,1:3]
medians_agg1[1:3,1:3]

pheatmap(medians_se1)
pheatmap(medians_se1[,-2])


library(limma)     # treat it like gene expression
plotMDS(t(medians_se1))
plotMDS(t(medians_se1), col=c("blue","orange")[as.numeric(as.factor(md$condition))])

#------------------------------------------------------------
# do percentile-based scaling (observations to 0-1)
#------------------------------------------------------------

# percentile normalization for a random sequence of numbers
q <- c(.001, .999)
cq <- apply(dtrans, 2, quantile, prob=q)

# calculating percentile for 1 vector
dnorm <- t( (t(dtrans)-cq[1,]) / (cq[2,]-cq[1,]) )
colnames(dnorm) <- unname(colnames(dnorm))


#------------------------------------------------------------
# run a tSNE projection
#------------------------------------------------------------
set.seed(123)

# take 1000 cells for each sample
# n.b.: if some cells have < 1000 cells, this wouldn't work
inds <- split(1:nrow(dtrans), samp) 
inds <- lapply(inds, sample, size=1000, replace=FALSE)
ix <- unlist(inds)

# run Barnes Hut SNE
dtsne <- dtrans[ix,marker_cols]
dim(dtsne)
out_rtsne <- Rtsne(dtsne, dims = 2, verbose = TRUE, 
                   pca=FALSE, max_iter = 500)

# prepare the tSNE data
df_tsne <- data.frame(tSNE1=out_rtsne$Y[,1],
                      tSNE2=out_rtsne$Y[,2])

# plot tSNE 
ggplot(df_tsne, aes(x = tSNE1, y = tSNE2)) +
  geom_point(size = 0.5)


df_tsne <- cbind(df_tsne, dtrans[ix,marker_cols])
colnames(df_tsne) <- make.names(colnames(df_tsne))


ggplot(df_tsne, aes(x = tSNE1, y = tSNE2, color=CD4.Nd145.Dd)) +
  geom_point(size = 0.5) 


df_tsne$samp <- rep(names(inds), sapply(inds,length))

ggplot(df_tsne, aes(x = tSNE1, y = tSNE2, color=CD4.Nd145.Dd)) +
  geom_point(size = 0.5) +
  facet_wrap(~samp)


df_tsne$condition <- rep(md$condition, sapply(inds,length))

ggplot(df_tsne, aes(x = tSNE1, y = tSNE2, color=CD4.Nd145.Dd)) +
  geom_point(size = 0.5) +
  facet_wrap(~condition)


# need to say how to save plots in PDF files: ggsave()




#------------------------------------------------------------
# FlowSOM clustering
#------------------------------------------------------------
# make flowframe of the whole (already-transformed) dataset 
ff_new <- flowFrame(exprs = dtrans)
ff_new


# run FlowSOM (with set.seed for reproducibility)
set.seed(123)
out_fSOM <- FlowSOM::ReadInput(ff_new, transform = FALSE, 
                               scale = FALSE, compensate = FALSE)
out_fSOM <- FlowSOM::BuildSOM(out_fSOM, colsToUse = marker_cols)

# pull out labels before metaclustering
labels <- out_fSOM$map$mapping[,1]
table(labels)

# pull out labels after metaclustering
mc_fsom <- FlowSOM::metaClustering_consensus(out_fSOM$map$codes, k=20)
clust <- mc_fsom[out_fSOM$map$mapping[,1]]

table(clust)

df_tsne$cluster <- as.factor(clust[ix])

ggplot(df_tsne, aes(x = tSNE1, y = tSNE2, color=cluster)) +
  geom_point(size = 2, alpha=.9) 



#------------------------------------------------------------
# make heatmaps .. of relative frequencies, markers by clusters
#------------------------------------------------------------

df_clust <- data.frame(dtrans[,marker_cols])
df_clust$clust <- clust
medians_clust_t <- df_clust %>%
  group_by(clust) %>% 
  summarize_each(funs(median))

medians_clust_t1 <- medians_clust_t[,-1]
pheatmap(medians_clust_t1, cluster_cols = FALSE, 
         display_numbers=TRUE)


df_clust <- data.frame(dnorm[,marker_cols])
df_clust$clust <- clust
medians_clust_n <- df_clust %>%
  group_by(clust) %>% 
  summarize_each(funs(median))


medians_clust_n1 <- medians_clust_n[,-1]
pheatmap(medians_clust_n1, cluster_cols = FALSE, 
         display_numbers=TRUE)


# add in additional markers
all_marker_cols <- c(3:4, 7:9, 11:19, 21:22, 24:26, 28:31, 33)

cols <- c(marker_cols, 
          setdiff(all_marker_cols,marker_cols))
df_clust <- data.frame(dnorm[,cols])
df_clust$clust <- clust

medians_clust_n <- df_clust %>%
  group_by(clust) %>% 
  summarize_each(funs(median))


medians_clust_n1 <- medians_clust_n[,-1]
pheatmap(medians_clust_n1, cluster_cols = FALSE, 
         display_numbers=TRUE, gaps_col=length(marker_cols))


#------------------------------------------------------------
# generate table of cell counts
#------------------------------------------------------------
df_cells <- data.frame(clust=clust, samp=samp)
cell_counts <- df_cells %>%
  group_by(samp,clust) %>% 
  tally

cell_counts_a <- acast(cell_counts, clust ~ samp, value.var="n", fill=0)

head(cell_counts_a)


# optional: treat as RNA-seq data as the cluster frequency level
library(edgeR)
#d <- calcNormFactors(d)
d <- DGEList(cell_counts_a)
plotMDS(d)
round(cpm(d)/1e6*100,2)

#------------------------------------------------------------
# generate median marker intensities for each cluster
#------------------------------------------------------------
df_cells <- data.frame(clust=clust, samp=samp,
                       dtrans[,setdiff(all_marker_cols,marker_cols)])
cluster_intens <- df_cells %>%
  group_by(samp,clust) %>% 
  summarize_each(funs(median))

cn <- make.names(colnames(dtrans[,setdiff(all_marker_cols,marker_cols)]))
names(cn) <- cn

# run acast() separately for each column
mats <- lapply(cn, function(u) {
  acast(cluster_intens, clust ~ samp, value.var=u, fill=NA)
})
nrows <- sapply(mats, nrow)
mats <- do.call("rbind", mats)

rownames(mats) <- paste0( rep(names(nrows),nrows), 
                          "_", rownames(mats))
head(mats,3)



# exploring differences of interest
df <- data.frame(pS6=mats["pS6.Yb172.Dd_18",],
                 sample=md$shortname, 
                 condition=md$condition)

ggplot(df, aes(x=sample, y=pS6, colour=condition)) + 
  geom_bar(size=2, width=.5, stat="identity") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))




plotMDS(mats)


