
## Exercise:

# 1. Read in the "example.fcs" file
list.files()
library(flowCore)
fcs <- read.FCS("example.fcs")
fcs

# 2. Extract the 'exprs' (ion counts) into a matrix

e <- exprs(fcs)
dim(e)
head(e,2)

cbind(1:ncol(e), colnames(e))

# 3. Remove the columns that are not of interest (i.e.,  
#   (Time, Cell_length, BC1-BC7, DNA-1, DNA-2)
#   alternatively, *subset* to markers that are of interest

keep <- c(3,4,7,8,9,11:19,21,22,24:26,28:31,33)
e_subset <- e[,keep]
dim(e_subset)

# 4. Transform the data in this matrix using asinh(x/5)

e_subset <- asinh(e_subset / 5)
head(e_subset, 2)

# 5. Make a histogram of the CD3 signal across all cells

hist( e_subset[,"CD3(110:114)Dd"], 200 )

df <- data.frame(e_subset)
head(df, 2)

colnames(df)[1] <- "CD3"
colnames(df)[5] <- "CD4"

library(ggplot2)
ggplot(df, aes(x=CD3)) + geom_histogram(bins = 20)

# 6. Make a bivariate plot of CD3 and CD4

ggplot(df, aes(x=CD3, y=CD4)) + geom_point()


# 7. From the 2739 cells, create a 2D tSNE projection 
#    (input 2739 rows x 24 columns --> output: 2739x2 matrix)

library(Rtsne)
tsne <- Rtsne(e_subset, verbose=TRUE, pca=FALSE)


# 8. Plot the tSNE projection (scatter plot)

head(tsne$Y, 2)
dim(tsne$Y)

plot(tsne$Y)

# 9. Plot the tSNE projection with dots coloured 
#    according to CD3 (scatter plot with each dot's
#    colour from a colour scale)

colnames(tsne$Y) <- paste0("tSNE",1:2)
head(tsne$Y, 2)

df <- cbind(df, tsne$Y)
head(df, 2)

ggplot(df, aes(x=tSNE1, y=tSNE2, colour=CD4)) +
  geom_point()

  
# 10. Add the tSNE projection to your flowFrame/flowSet 
#     object and write it out in an FCS file.
#     Open the FCS file in FlowJo/Cytobank to verify that it worked.

class(fcs)
head(df,2)

new_fcs <- new("flowFrame", exprs=as.matrix(df))
new_fcs

write.FCS(new_fcs, "example_modified.fcs")
