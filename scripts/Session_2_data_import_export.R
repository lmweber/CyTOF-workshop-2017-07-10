###########################################
# Example: Getting data into and out of R #
# Lukas Weber, July 2017                  #
###########################################


# --------
# Comments
# --------

# Lines beginning with # are "comments", which are ignored by R. Comments are usually
# included as headings and to explain what each part of your script does. They are very
# useful as reminders and explanations for yourself and other people about what your code
# does. Always try to include lots of comments!



# -----------------
# Working directory
# -----------------

# Your "working directory" is the location in your computer's file system where your R
# session is currently running. R will look for and save files here.

# The current working directory is shown next to the heading in the Console window
# (bottom-left panel). It can also be checked with the following command:

getwd()

# You can change your working directory in several ways:

# (1) Using the menus in the Files window (bottom-right panel):
# - click on the Files tab (bottom-right panel)
# - click on the three dots "..." (at the top-right of the Files panel)
# - navigate to the folder you want to use
# - then click on "More" and "Set as working directory" (at the top of the Files panel)

# (2) Using the RStudio menus:
# - click on "Session"
# - select "Set Working Directory" -> "To Source File Location"

# (3) Using the following command:

setwd("~/Desktop")

# Now change it back using the menus in the Files panel.


# You can also list the files in the current working directory:

list.files()



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


# Save the data matrix as a .csv file (simple spreadsheet without any formatting, which
# can be opened in Excel)

?write.csv

write.csv(dat, file = "my_data_matrix.csv")



# -------------------------------------
# Loading / reading in data from a file
# -------------------------------------

# Read in the data matrix and assign it to a new variable name.

dat2 <- read.csv("my_data_matrix.csv")

dat2

str(dat2)


# If you have a data file saved in ".txt" format instead of ".csv", you can use the
# following function instead:

?read.table

dat3 <- read.table("my_data_matrix.txt")

dat3 <- read.table("my_data_matrix.txt", header = TRUE)

dat3



