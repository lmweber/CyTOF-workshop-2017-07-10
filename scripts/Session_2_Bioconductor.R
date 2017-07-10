##############################################################
# Installing and loading packages from CRAN and Bioconductor #
# Lukas Weber, July 2017                                     #
##############################################################


# -------------------------
# Install package from CRAN
# -------------------------

install.packages("ggplot2")



# ---------------------------------
# Install package from Bioconductor
# ---------------------------------

# Run the installation script ("biocLite.R") directly from the Bioconductor website

source("https://bioconductor.org/biocLite.R")

?source


# Install package (downloads and saves the package files on your local computer)

biocLite("flowCore")

?biocLite



# -------------
# Load packages
# -------------

# Load the installed packages into your current R session, so you can use them

library(ggplot2)
library(flowCore)


