##########################################################################################
# Session 3: R Programming and plotting                                                  #
#                                                                                        #
# Based on Data Carpentry R-ecology lesson: "R for data analysis and visualization of    #
# Ecological Data": http://www.datacarpentry.org/R-ecology-lesson/                       #
#                                                                                        #
# Adapted to use CyTOF data set initially published by Bodenmiller et al. (2012), Nature #
# Biotechnology; and re-analyzed by Bruggner et al. (2014), PNAS.                        #
#                                                                                        #
# Lukas Weber, July 2017                                                                 #
##########################################################################################


##################
# Creating objects
##################

# Note: First few sections are based on:
# http://www.datacarpentry.org/R-ecology-lesson/01-intro-to-R.html


# Evaluate a simple expression
3 + 5

# Assign value to variable: arrow symbol "<-" is "assignment operator"
weight_kg <- 12

weight_kg

2.2 * weight_kg

# Assign new value
weight_kg <- 16

2.2 * weight_kg



###############################
# Functions and their arguments
###############################

# Pre-defined functions; one or more "arguments"
sqrt(9)

b <- sqrt(9)
b

?sqrt

round(3.14159)
?round

round(3.14159, digits = 2)
round(3.14159, 2)



########################
# Vectors and data types
########################

weight_g <- c(21, 34, 39, 54)
weight_g

animals <- c("mouse", "rat", "dog", "cat")
animals

length(weight_g)
length(animals)

class(weight_g)
class(animals)

?class

str(weight_g)
str(animals)

?str


# Extend vector to include new objects
weight_g_new <- c(weight_g, 90)
weight_g_new

weight_g_new <- c(30, weight_g)
weight_g_new


# Note: Fundamental vector types: 
# - "numeric"
# - "character"
# - "logical": TRUE or FALSE
# - "integer": e.g. 2L



####################
# Subsetting vectors
####################

animals

animals[2]

animals[c(3, 2)]

animals[-3]


# Conditional subsetting (using TRUE/FALSE)
weight_g

weight_g[c(TRUE, FALSE, FALSE, TRUE)]

cnd <- c(TRUE, FALSE, FALSE, TRUE)
weight_g[cnd]

weight_g > 50

# using "greater than"
weight_g[weight_g > 50]

# using "less than"; "or"
weight_g[weight_g < 30 | weight_g > 50]

# using "and"; "equal to"
weight_g[weight_g >= 30 & weight_g == 21]

animals[animals == "cat" | animals == "rat"]

# using "%in%"
animals %in% c("rat", "cat", "dog", "duck")

animals[animals %in% c("rat", "cat", "dog", "duck")]



##############
# Missing data
##############

# In R, missing values are represented by the symbol "NA" (for "not available"). This is
# very useful in data analysis, since most R functions can recognize "NA" and deal with it
# correctly. Coding missing values as "NA" is much safer than using unusual numbers (e.g.
# 0, -1, -99), since numbers will be interpreted as actual data values.

heights <- c(2, 4, 4, NA, 6)

mean(heights)
max(heights)

# use "na.rm" argument to get result
mean(heights, na.rm = TRUE)
max(heights, na.rm = TRUE)

# "is.na()"
?is.na
heights[!is.na(heights)]


# Challenge: Create a new vector with NAs removed

lengths <- c(10, 24, NA, 18, NA, 20)

lengths_complete <- lengths[!is.na(lengths)]
lengths_complete

# Challenge: Use "median()" to calculate median length

median(lengths)
median(lengths_complete)



######################
# Data structures in R
######################

# Note: For more details see:
# http://www.datacarpentry.org/R-ecology-lesson/02-starting-with-data.html


# Data structures:
# - vector
# - list
# - matrix
# - data.frame
# - factor


# Create a vector

my_vector <- c(1, 2, 3, 4)
my_vector

class(my_vector)

str(my_vector)

length(my_vector)


# Create a matrix

?matrix

my_matrix <- matrix(1:12, nrow = 3, ncol = 4)
my_matrix

my_matrix <- matrix(1:12, nrow = 3, ncol = 4, byrow = TRUE)
my_matrix

class(my_matrix)

str(my_matrix)

dim(my_matrix)

length(my_matrix)  # note: not what we expected!


# Create a data frame

animals <- c("mouse", "rat", "dog", "cat")
weight <- c(21, 34, 6500, 3200)
age <- c(0.1, 0.2, 9, 3) 

my_df <- data.frame(animals, weight, age)
my_df

class(my_df)

dim(my_df)

str(my_df)

# Note: Each column can contain a different data type. This is in contrast to matrices, 
# where the whole matix needs to be the same data type.

# alternatively: create a data frame from a matrix
my_df2 <- as.data.frame(my_matrix)
my_df2

str(my_df2)


# Create a list

my_list <- list("dog", "cat", 3, 2.5)
my_list

str(my_list)

# Note: Each list item can be a different data type. This is in contrast to vectors, where
# the whole vector needs to be a single data type.

my_list2 <- list("dog", "cat", 3, 2.5, TRUE)
my_list2


# Create a factor

animals <- c("dog", "dog", "cat", "cat", "dog")
animals
class(animals)

my_factor <- factor(animals)
my_factor

class(my_factor)
str(my_factor)

levels(my_factor)  # factor "levels" are ordered alphabetically by default

nlevels(my_factor)

as.numeric(my_factor)  # factor values are stored internally as numeric values

# Factors are very useful as a replacement for character vectors in applications where the
# "levels" have specific meaning, e.g. in statistical models and plotting.



#########################
# Plotting with "ggplot2"
#########################

# Note: For more details see: 
# http://www.datacarpentry.org/R-ecology-lesson/04-visualization-ggplot2.html


# install packages (if required)
#install.packages("ggplot2")
#source("https://bioconductor.org/biocLite.R")
#biocLite("flowCore")


# load packages
library(ggplot2)
library(flowCore)


# ---------
# Load data
# ---------

filename <- "example.fcs"

data_raw <- read.FCS(filename, transformation = FALSE, truncate_max_range = FALSE)

data_exprs <- exprs(data_raw)

head(data_exprs)
summary(data_exprs)
dim(data_exprs)
class(data_exprs)


# -----------
# Subset data
# -----------

# Subset the expression matrix to keep only columns of interest (protein marker columns).

colnames(data_exprs)

cols_keep <- c(3:4, 7:9, 11:19, 21:22, 24:26, 28:31, 33)

# check
colnames(data_exprs)[cols_keep]

data_sub <- data_exprs[, cols_keep]


# --------------
# Transform data
# --------------

# Note: We will use an "arcsinh" transform with "cofactor" = 5. This is a standard
# transform for CyTOF data; see Bendall et al. (2011), Supplementary Figure S2.

cofactor <- 5

data_transf <- asinh(data_sub / cofactor)

?asinh

summary(data_transf)
dim(data_transf)


# ------------------
# Create simple plot
# ------------------

# Plot CD4 vs. CD3

colnames(data)

plot(data_transf[, c(1, 5)])


# -----------------------------------------
# Create more advanced plot using "ggplot2"
# -----------------------------------------

# We will use the "ggplot2" package to create more advanced plots. The "ggplot2" package
# uses a consistent, systematic syntax that lets you build flexible, well-presented plots
# with relative ease. However, the syntax takes some getting used to, so we will start
# with a simple example.

# For more examples, or if you get stuck, it is always useful to search on Google or Stack
# Overflow to find some code examples.


# "ggplot2" requires data to be formatted as a data frame

df_plot <- as.data.frame(data_transf)

head(df_plot)


# Column names cannot include special characters such as parentheses, so we will change
# them manually

colnames(df_plot)

colnames(df_plot)[c(1, 5)]

colnames(df_plot)[c(1, 5)] <- c("CD3", "CD4")

head(df_plot)


# Create plot

ggplot(df_plot, aes(x = CD3, y = CD4)) + 
  geom_point()

# Note specific points about syntax:
# - "ggplot" command
# - first argument: data frame
# - second argument: "aesthetic mappings" (e.g. what goes on x and y axes, or colors)
# - no quotes around column names
# - "geom_point()": draw points (as opposed to bars, box plots, contours, etc)
# - "+" at end of first line


# Various plotting options

ggplot(df_plot, aes(x = CD3, y = CD4)) + 
  geom_point(color = "blue")

ggplot(df_plot, aes(x = CD3, y = CD4)) + 
  geom_point(color = "blue", alpha = 0.25)

ggplot(df_plot, aes(x = CD3, y = CD4)) + 
  geom_point(color = "blue", alpha = 0.25) + 
  theme_bw()

ggplot(df_plot, aes(x = CD3, y = CD4)) + 
  geom_point(color = "blue", alpha = 0.25) + 
  xlab("CD3 expression (transformed)") + 
  ylab("CD4 expression (transformed)") + 
  ggtitle("CD4 vs. CD3") + 
  theme_bw()

ggplot(df_plot, aes(x = CD3, y = CD4)) + 
  geom_point(color = "blue", alpha = 0.25) + 
  xlim(c(-1.75, 5)) + 
  ylim(c(-1.25, 5.75)) + 
  xlab("CD3 expression (transformed)") + 
  ylab("CD4 expression (transformed)") + 
  ggtitle("CD4 vs. CD3") + 
  theme_bw()


# Add contour lines with a second "geom"

ggplot(df_plot, aes(x = CD3, y = CD4)) + 
  geom_point(color = "blue", alpha = 0.25) + 
  geom_density2d(color = "gray30") + 
  xlim(c(-1.75, 5)) + 
  ylim(c(-1.25, 5.75)) + 
  xlab("CD3 expression (transformed)") + 
  ylab("CD4 expression (transformed)") + 
  ggtitle("CD4 vs. CD3") + 
  theme_bw()


# Save your plot

getwd()

ggsave("my_plot.pdf", width = 7, height = 7)

ggsave("my_plot.png", width = 7, height = 7)


# Alternatively, assign the plot to a variable name before saving. This can be useful when
# you want to generate and save multiple plots.

my_plot <- ggplot(df_plot, aes(x = CD3, y = CD4)) + 
  geom_point(color = "blue", alpha = 0.25) + 
  geom_density2d(color = "gray30") + 
  xlim(c(-1.75, 5)) + 
  ylim(c(-1.25, 5.75)) + 
  xlab("CD3 expression (transformed)") + 
  ylab("CD4 expression (transformed)") + 
  ggtitle("CD4 vs. CD3") + 
  theme_bw()

my_plot

ggsave("my_plot.pdf", plot = my_plot, width = 7, height = 7)


