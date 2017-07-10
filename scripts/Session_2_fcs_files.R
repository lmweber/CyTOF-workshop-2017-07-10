################################################
# Example: Data import/export using .fcs files #
# Lukas Weber, July 2017                       #
################################################


# First set working directory: Navigate to the correct folder using "..." in the Files
# window (bottom-right panel), then click on "More" and "Set as working directory"

# check
getwd()


# ---------------
# Find .fcs files
# ---------------

list.files(".", pattern = "fcs")

# if saved in a subdirectory called "data"
list.files("data", pattern = "fcs")

?list.files

filename <- "example.fcs"

filename



# ---------
# Load data
# ---------

library(flowCore)

?read.FCS

dat <- read.FCS(filename, transformation = FALSE, truncate_max_range = FALSE)

# Note: options "transformation = FALSE" and "truncate_max_range = FALSE" are useful for
# CyTOF data

# check
dat



# -------------------------
# Extract expression values
# -------------------------

# The full data object contains additional information, e.g. row and column metadata. For
# analysis such as clustering and dimension reduction, we need to extract the raw
# expression values first.

dat_exprs <- exprs(dat)

?exprs

?head

head(dat_exprs)



# ----------------------------
# Save data as a new .fcs file
# ----------------------------

filename_new <- "my_new_file.fcs"

write.FCS(flowFrame(dat_exprs), filename = filename_new)

?write.FCS

# Note that the data table must be a "flowFrame" object; this is why we include a call to
# the "flowFrame" function within "write.FCS".

# Note: The function "write.FCS()" always gives a warning message, which is fine.


# Save it in a different folder (first create a new folder called "data2")

filename_new2 <- "data2/my_new_file.fcs"

write.FCS(flowFrame(dat_exprs), filename = filename_new2)



