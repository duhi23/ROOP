###############################
##### Script - data.table #####
###############################

# 1) Novice

# Welcome to the interactive exercises part of your data.table course. Here you will learn the ins and outs 
# of working with the data.table package.
# While most of the material is covered by Matt and Arun in the videos, you will sometimes need to show some 
# street smartness and inventiveness. Remember that before using the hint you can always have a look at the 
# official documentation by typing ?data.table in the console.
# Let us start with some warming-up exercises on the topics that were covered in this first section. For this 
# first exercise you may need to watch the video again at point 03:03 to find out how to create integer columns 
# and notice the use of c() to create vectors. Click the video button on the bottom left. By now you realise 
# you must watch the video very carefully and keep up :) You can also flick through the slides by pressing the 
# slides button.

library("data.table")

# Create a data.table my_first_data_table with a column x = c("a","b","c","d","e") and a column y = c(1,2,3,4,5). 
# Use data.table().
my_first_data_table <- data.table(x = c("a","b","c","d","e"), y = c(1,2,3,4,5))

# Create a two-column data.table DT that contains the four integers 1,2,1,2 in the first column a and the letters 
# A,B,C,D in the second column b. Use recycling.
DT <- data.table(a = 1:2, b = c("A", "B", "C", "D"))

# Select the third row of DT and just print the result to the console.
DT[3,]

# Select the second and third rows without using any comma at all and print the result to the console.
DT[2:3]

# You can pass data.table to base R functions like head() and tail() that accept a data.frame. Also, keep in 
# mind that the special symbol .N contains the number of rows. You can put this symbol inside square brackets.

# Select the penultimate row of the table. Make use of .N for this.
DT[.N-1]

# Return the column names of the data.table.
colnames(DT)

# Return the number of rows and number of columns of the data.table.
dim(DT)

# Select row 2 twice and row 3, returning a data.table with three rows where row 2 is a duplicate of row 1.
DT[c(2,2,3)]

# Just a small reminder: speak out loud and say "Take DT, subset rows using i, then calculate j grouped by by".
# In the video, the second argument j was covered. j can be used to select columns by wrapping the column names 
# in .(). In addition to selecting columns, you can also call functions on them as if the columns were variables.

# Create a subset columns B and C for rows 1 and 3, and print the result to the console.
DT[c(1,3),.(B,C)]

# Assign to ans a data.table that contains two columns: B and val, where val is the product of A and C.
ans <- DT[,.(B,val=A*C)]

# Assign to answ another data.table answ <- DT[, .(B, val = ____ )]. Fill in the blanks such that answ equals 
# data.table(B=c("a", "b", "c", "d", "e", "a", "b", "c", "d", "e"), val = as.integer(c(6,7,8,9,10,1,2,3,4,5))).
answ <- DT[, .(B, val = as.integer(c(6,7,8,9,10,1,2,3,4,5)))]

# In this section you were introduced to the last of the main parts of the data.table syntax: by. It was explained 
# that if you supply a j expression and a by list of expressions, the j expression is repeated for each by group. 
# It is time to test your understanding, and to master the by argument via some hands-on examples and exercises.
# First type iris and observe that all the rows are printed and that the column names scroll off the top of your 
# screen. This is because iris is a data.frame. Use the scroll bar to scroll to the top to see the column names. 
# Now convert iris to a data.table and store the result in DT. If you don't know how to convert, press the hint button.
# Once you have turned it into a data.table, you are ready to start using its functionalities…

# Convert the iris dataset to a data.table DT.
DT <- as.data.table(iris)

# For each Species, what is the mean Sepal.Length? Do not provide a name for the newly created column.
DT[,mean(Sepal.Length),by=Species]

# Do exactly the same as in the instruction above, but this time group by the first letter of the Species name instead.
DT[,mean(Sepal.Length),by=substring(Species, 1, 1)]

# We saw earlier that .N can be used in i and that it designates the number of rows in DT. There, it is typically 
# used for returning the last row or an offset from it. .N can be used in j too and designates the number of rows 
# in this group. The latter is especially powerful when you can use it in combination with by.

# Group the specimens by Sepal area (to the nearest 10 cm2) and count how many occur in each group.
DT[,.N, by=10*round(Sepal.Length*Sepal.Width/10)]

# Using the answer to the above question, you can now name the group Area and the count Count.
DT[,.(Count=.N), by=.(Area=10*round(Sepal.Length*Sepal.Width/10))]

# In the previous exercises we returned single numbers in j. However, this is not necessary, because you do not 
# have to return only single numbers in j. Let us experiment with this via a new data.table DT .

# The data.table DT
set.seed(1L)
DT <- data.table(A=rep(letters[2:1], each=4L), B=rep(1:4, each=2L), C=sample(8))

# Given DT, calculate cumulative sum of C in column C while you group by A,B. Store it in a new data.table DT2 
# with 3 columns A,B and C.
DT2 <- DT[, .(C=cumsum(C)), by=.(A,B)]

# Select from DT2, the last two values of C in column C while you group by A alone. Make sure the column names 
# won't change.
DT2[, .(C=tail(C,2)), by=A] 

# 2) Yeoman




