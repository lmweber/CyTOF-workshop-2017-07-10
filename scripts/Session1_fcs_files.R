################################################
# Example: Data import/export using .fcs files #
# Lukas Weber, March 2017                      #
################################################


# Set working directory: Navigate to correct folder using "..." in the Files window 
# (bottom-right panel), then click on "More" and "Set as working directory"

getwd()


# Find .fcs files

list.files(".", pattern = "\\.fcs$")

list.files("data", pattern = "\\.fcs$")

?list.files


# Note: "\\.fcs$" is a "regular expression", which tells R to look for all files ending in
# ".fcs". The two back-slashes "\\" are required because the dot "." is a special symbol; 
# and the "$" symbol tells R we are interested in the end of the filename. For more 
# details Google "regular expressions."

filename <- "data/example.fcs"
filename

filename <- list.files("data", pattern = "\\.fcs$", full.names = TRUE)
filename


# Load data

library(flowCore)

?read.FCS

dat <- read.FCS(filename, transformation = FALSE, truncate_max_range = FALSE)

# Note: options "transformation = FALSE" and "truncate_max_range = FALSE" are useful for
# CyTOF data


# Show information about the whole data object

dat


# Show expression values only

?exprs

?head

head(exprs(dat))


# Save data as a new .fcs file

fn_new <- "my_fcs_file.fcs"

?write.FCS

write.FCS(dat, filename = fn_new)

# Note: The function "write.FCS()" gives a warning message; this is okay.


# Save it in a different folder

fn_new2 <- "~/Desktop/my_fcs_file.fcs"

write.FCS(dat, filename = fn_new2)


