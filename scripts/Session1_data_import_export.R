###########################################
# Example: Getting data into and out of R #
# Lukas Weber, March 2017                 #
###########################################


# --------------
# Note: Comments
# --------------

# Lines beginning with # are "comments", which are ignored by R. Comments are usually 
# included as headings and to explain what each part of your script does. They are very 
# useful for other people who are using your script, or yourself in the future. Always try
# to include lots of comments!



# -----------------
# Working directory
# -----------------

# Your "working directory" is the location in your computer's file system where your R 
# session is currently running. R will look for and save files here.

# The current working directory is shown next to the heading in the Console window 
# (bottom-left panel). It can also be checked with the following command:

getwd()

# You can change your working directory by using the menus in the Files window 
# (bottom-right panel):
# - click on the Files tab (bottom-right panel)
# - click on the three dots "..." (at the top-right of the Files panel)
# - navigate to the folder you want to use
# - then click on "More" and "Set as working directory" (at the top of the Files panel)

# Alternatively, you can use the following command:

setwd("~/Desktop")

# Now change it back using the menus in the Files panel.

# You can also list the files in the current working directory:

list.files()

# Now go to Finder (Mac) or Windows Explorer (Windows), navigate to the same folder, and 
# confirm that R is showning all the same files.



# ------------
# Getting help
# ------------

# In R: Type "?" or "help" and the name of the function you are interested in. The
# function's help file will then show in the bottom-right panel.

?list.files

help(list.files)

# Outside R: Google, Stack Overflow



# -------------
# Saving a file
# -------------

# Create a matrix of data

dat <- matrix(1:12, nrow = 3, ncol = 4)

dat

View(dat)

?matrix


# Save the data matrix as a .txt file

?write.table

write.table(dat, file = "my_data_matrix.txt", sep = "\t")

write.table(dat, file = "my_data_matrix.txt", sep = "\t", row.names = TRUE, col.names = TRUE)

# Now find it in Finder or Windows Explorer, and check that it contains the correct data, 
# by double-clicking to open it. Note the format: tab-spacing; row and column names are in
# quotes.


# Save the data matrix as a .csv file (simple spreadsheet without any formatting)

?write.csv

write.csv(dat, file = "my_data_matrix.csv")

# Check it by double-clicking to open in Excel.



# -------------------------------------
# Loading / reading in data from a file
# -------------------------------------

# Make some changes to the data table in Excel, e.g. change one of the values or add a new
# column. Then save.

# (Note: When you are working with a real data set, never change your actual data in 
# Excel, since this makes it very hard to keep track of your changes, and may make it 
# difficult or impossible to reproduce your analyses. Instead, use R or Cytobank for your 
# main data analyses, and Excel to set up your meta-data tables and inspecting final 
# output tables of results; more on meta-data tables later.)

# Now read in your new data table and assign it to a new variable.

dat2 <- read.csv("my_data_matrix.csv")

dat2

# "read.csv" already worked correctly with default settings

dat2 <- read.csv("my_data_matrix.csv", header = TRUE, stringsAsFactors = FALSE)

dat2

str(dat2)


# If you have a data file saved in ".txt" format instead of ".csv" (e.g. output from
# write.table above), you can use the following function instead:

?read.table

dat3 <- read.table("my_data_matrix.txt")

dat3 <- read.table("my_data_matrix.txt", header = TRUE)

dat3


# Note: There are also functions to read in data directly from Excel spreadsheets in .xlsx
# format. We will show this in Sessions 3 and 4.



