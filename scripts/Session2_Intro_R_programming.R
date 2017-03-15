##########################################################################################
# Session 2: Introduction to R Programming                                               #
#                                                                                        #
# Based on Data Carpentry R-ecology lesson: "R for data analysis and visualization of    #
# Ecological Data": http://www.datacarpentry.org/R-ecology-lesson/                       #
#                                                                                        #
# Adapted to use CyTOF data set initially published by Bodenmiller et al. (2012), Nature #
# Biotechnology; and re-analyzed by Bruggner et al. (2014), PNAS.                        #
#                                                                                        #
# Lukas Weber, March 2017                                                                #
##########################################################################################


####################
# Creating objects #
####################

# Note: First few sections are based on:
# http://www.datacarpentry.org/R-ecology-lesson/01-intro-to-R.html


# Evaluate a simple expression
3 + 5

# Assign value to variable: arrow symbol "<-" is "assignment operator"
weight_kg <- 55

weight_kg

2.2 * weight_kg

# Assign new value
weight_kg <- 57.5

2.2 * weight_kg



#################################
# Functions and their arguments #
#################################

# Pre-defined functions; one or more "arguments"
sqrt(9)

b <- sqrt(9)
b

?sqrt

round(3.14159)
?round

round(3.14159, digits = 2)
round(3.14159, 2)



##########################
# Vectors and data types #
##########################

weight_g <- c(50, 60, 65, 82)
weight_g

animals <- c("mouse", "rat", "dog")
animals

length(weight_g)
length(animals)

class(weight_g)
class(animals)

?class

str(weight_g)
str(animals)

?str


# Add objects to existing vector
weight_g <- c(weight_g, 90)
weight_g <- c(30, weight_g)
weight_g


# "Atomic" vector types: 
# - "numeric"
# - "character"
# - "logical": TRUE or FALSE
# - "integer": e.g. 2L
# - (also: "complex", "raw")


# Challenge: What do you think will happen in each of the following examples?

# hint: ?class

num_char <- c(1, 2, 3, 'a')
num_char
class(num_char)

num_logical <- c(1, 2, 3, TRUE)
num_logical
class(num_logical)

char_logical <- c('a', 'b', 'c', TRUE)
char_logical
class(char_logical)

tricky <- c(1, 2, 3, '4')
tricky
class(tricky)



######################
# Subsetting vectors #
######################

animals <- c("mouse", "rat", "dog", "cat")
animals[2]

animals[c(3, 2)]

more_animals <- animals[c(1, 2, 3, 2, 1, 4)]
more_animals

# Note: R indexes start at 1 (some other programming languages e.g. Python start at 0)


# Conditional subsetting (using TRUE/FALSE)
weight_g <- c(21, 34, 39, 54, 55)
weight_g[c(TRUE, FALSE, TRUE, TRUE, FALSE)]

cnd <- c(TRUE, FALSE, TRUE, TRUE, FALSE)
weight_g[cnd]

weight_g > 50

# using "greater than"
weight_g[weight_g > 50]

# using "less than"; "or"
weight_g[weight_g < 30 | weight_g > 50]

# using "and"; "equal to"
weight_g[weight_g >= 30 & weight_g == 21]

animals <- c("mouse", "rat", "dog", "cat")
animals[animals == "cat" | animals == "rat"]

# using "%in%"
animals %in% c("rat", "cat", "dog", "duck")

animals[animals %in% c("rat", "cat", "dog", "duck")]


# Challenge: Why does this return "TRUE"?

"four" > "five"



################
# Missing data #
################

# In R, missing values are represented by "NA" in vectors. This is very useful in data 
# analysis, since most R functions can recognize "NA" and deal with it correctly. Coding 
# missing values as "NA" is much safer than using numbers (e.g. 0, -1, -99), since R will 
# interpret these numbers as actual data values. Note that the concept of missing values
# is uncommon in other programming languages.

heights <- c(2, 4, 4, NA, 6)

mean(heights)
max(heights)

# use "na.rm" argument
mean(heights, na.rm = TRUE)
max(heights, na.rm = TRUE)

# compare when using 0 or -99 to code missing values
mean(c(2, 4, 4, 0, 6))
mean(c(2, 4, 4, -99, 6))

# "is.na()"
?is.na
heights[!is.na(heights)]

# "na.omit()"
?na.omit
na.omit(heights)

# "complete.cases()"
?complete.cases
heights[complete.cases(heights)]


# Challenge: Create a new vector with NAs removed

lengths <- c(10, 24, NA, 18, NA, 20)

lengths_complete <- lengths[!is.na(lengths)]
lengths_complete

# Challenge: Use "median()" to calculate median length

median(lengths)
median(lengths_complete)



########################
# Data structures in R #
########################

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

length(my_matrix)  # not what we expected!

dim(my_matrix)


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


# Create a factor (if time); not too much on factors

animals <- c("dog", "dog", "cat", "cat", "dog")
animals
class(animals)

my_factor <- factor(animals)
my_factor

class(my_factor)
str(my_factor)

levels(my_factor)  # factor "levels" are ordered alphabetically by default
?levels

nlevels(my_factor)

as.numeric(my_factor)  # factor values are stored internally as numeric values

# Note: Factors are another unique feature of R. They are useful as a replacement for 
# character vectors in a number of applications where the "levels" have specific meaning,
# e.g. statistical models and plotting.



###############################################
# Plotting with "base plotting" and "ggplot2" #
###############################################

# Note: For more details see: 
# http://www.datacarpentry.org/R-ecology-lesson/04-visualization-ggplot2.html

# Note: We will use the CyTOF example data set from Session 1 (single .fcs file) for these
# first few examples. In Sessions 3 and 4, we will use the full data set to demonstrate an
# extended CyTOF data analysis workflow, including plotting.


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

filename <- "data/example.fcs"
data <- read.FCS(filename, transformation = FALSE, truncate_max_range = FALSE)
data <- exprs(data)

head(data)
dim(data)
summary(data)
class(data)


# --------------
# Transform data
# --------------

# Note: We will use an "arcsinh" transform with "cofactor" = 5. This is a standard
# transform for CyTOF data; see Bendall et al. (2011), Supplementary Figure S2.

cofactor <- 5
data <- asinh(data / cofactor)

?asinh

summary(data)

# Note: We have transformed all columns! including Time etc. In Sessions 3 and 4, we will 
# transform only the relevant columns (protein markers).


# -------------------------------------
# Create simple plot with base plotting
# -------------------------------------

# "Base plotting" refers to the built-in plotting commands in R. These commands are easy
# to use for very simple plots, but are tricky to fine-tune for more complex or nicer
# plots. We will use the "ggplot2" package to create more advanced plots.

# Plot CD4 vs. CD3

colnames(data)

plot(data[, c(3, 9)])

plot(data[, c(3, 9)], pch = ".")

plot(data[, c(3, 9)], pch = ".", cex = 3)

plot(data[, c(3, 9)], pch = ".", cex = 3, main = "CD4 vs. CD3")

?plot


# -------------------------
# Create plot using ggplot2
# -------------------------

# We will use the package "ggplot2" for more advanced plots. The "ggplot2" package allows 
# you to create much more flexible and well-presented plots, especially when you want to 
# show something complex. However, it requires learning some specific syntax.

# If you get stuck, you can almost always find an answer to your question on Google or 
# Stack Overflow, often with some example code.


# Subset data and create data frame with the data you want to plot (note: ggplot2 requires
# a data frame, not a matrix)

colnames(data)
df_plot <- as.data.frame(data[, c(3, 9)])

head(df_plot)
class(df_plot)

colnames(df_plot) <- c("CD3", "CD4")

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


# You can also assign your plot to a variable name (e.g. this is useful when you want to
# generate and save multiple plots)

p <- ggplot(df_plot, aes(x = CD3, y = CD4)) + 
  geom_point(color = "blue", alpha = 0.25) + 
  geom_density2d(color = "gray30") + 
  xlim(c(-1.75, 5)) + 
  ylim(c(-1.25, 5.75)) + 
  xlab("CD3 expression (transformed)") + 
  ylab("CD4 expression (transformed)") + 
  ggtitle("CD4 vs. CD3") + 
  theme_bw()

p

ggsave("my_plot.pdf", plot = p, width = 7, height = 7)


