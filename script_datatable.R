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

# Now that you are comfortable with data.table's DT[i, j, by] syntax, it is time to practice some other very 
# useful concepts in data.table as well. Here, you will have a more detailed look at chaining.
# Chaining allows concatenating multiple operations and follows because the operations are in the same order. 
# Furthermore, it helps to avoid the creation of unnecessary temporary variables (which could quickly clutter 
# one's workspace).

set.seed(1L)
DT <- data.table(A=rep(letters[2:1], each=4L), B=rep(1:4, each=2L), C=sample(8)) 

# In the previous section, you calculated DT2 by taking the cumulative sum of C while grouping by A,B. Next, 
# you selected from DT2 the last two values of C while grouping by A alone. Do this again, but this time use 
# the concept of chaining instead. Simply print the result of the chaining.
DT[,.(C = cumsum(C)), by=.(A,B)][,.(C=tail(C,2)),by=A]

# In the previous exercise you converted the iris dataset to data.table DT. That DT is now loaded in your 
# workspace. Check this first via the console. Let us see how you can use chaining to simplify manipulations 
# and calculations with the DT data.table.

# Get the median of all the four columns Sepal.Length, Sepal.Width, Petal.Length and Petal.Width while you 
# group by Species. Give them the same names. Next, order Species in descending order using chaining.
DT <- data.table(iris)
DT[, .(Sepal.Length=median(Sepal.Length), Sepal.Width=median(Sepal.Width), Petal.Length=median(Petal.Length), 
       Petal.Width=median(Petal.Width)), by=Species][order(Species, decreasing = TRUE)]

# It is a good idea to make use of familiar functions from base R to reduce programming time without losing 
# readability.
# The data.table package provides a special in-built variable .SD. It refers to the subset of data for each group.

# Get the mean of columns y and z grouped by x by using .SD.
DT[, lapply(.SD, mean), by=x]

# Get the median of columns y and z grouped by x by using .SD.
DT[, lapply(.SD, median), by=x]

# .SDcols specifies the columns of DT that are included in .SD. Using .SDcols comes in handy if you have too 
# many columns and you want to perform a particular operation on a particular subset of the columns (apart 
# from the grouping variable columns).
# While using data.table, you may find yourself looking back to the documentation. Have a look at ?data.table 
# for more info on .SDcols.

# Calculate the sum of the Q columns using .SD and .SDcols. Use 2:4.
DT[, lapply(.SD, sum), .SDcols=2:4]

# You can of course set .SDcols to be the result of a function call. This time calculate the sum of columns H1 
# and H2 using paste0().
DT[,lapply(.SD,sum), .SDcols=paste0("H",1:2)]

# Finally, select all but the first row of the groups names 6 and 8, returning only the grp column and the Q 
# columns. Use -1 in i of .SD and use paste0() again. Type desired_result to better understand what you need to do.
DT[,.SD[-1], by=grp, .SDcols=paste0("Q",1:3)]

# The final exercise of this section is a challenging one, so do not give up too soon! It is important to 
# remember that lapply() and .SD return a list, and that .N is an inbuilt variable that returns an integer 
# vector of length 1. If j returns a list then a data.table is returned. To combine items together you already 
# know to use c(). Combining a list with a vector makes a new list one longer. When you select .N on its own, 
# it automatically gets named N in the output for convenience when chaining.

# Get the sum of all columns x, y and z and the number of rows in each group while grouping by x. Your answer 
# should be identical to the result stored in desired_result_1.
DT[, c(lapply(.SD, sum), .N), by=x, .SDcols=c("x", "y", "z")]

# Get the cumulative sum of column x and y while grouping by x and z > 8 such that the answer looks like the 
# result that was stored in the variable desired_result_2.
DT[, lapply(.SD, cumsum),by=.(by1=x, by2=z>8), .SDcols=c("x", "y")]

# Use chaining to get the maximum of both x and y by combining the result that was obtained in the previous 
# instruction and group by by1.
DT[, lapply(.SD, cumsum),by=.(by1=x, by2=z>8), .SDcols=1:2][, lapply(.SD, max), by=by1, .SDcols=c("x", "y")]


# As you now know, := is defined for use in j only, and there are two ways of using it. The first is the 
# LHS := RHS form, where LHS is a character vector of column names and RHS is the corresponding value 
# (Note: LHS stands for Left Hand Side and RHS stands for Right Hand side in what follows).
# This first exercise will thoroughly test your understanding of this first way. So it is time for you to 
# show off your knowledge!

# Add a column Totalby reference containing sum(B) for each group in column A.
DT[, Total:=sum(B), by=A]

# Add 1 to column B just in rows 2 and 4.
DT[c(2,4), `:=` (B=B+1)]

# Add a new column Total2 that contains sum(B) grouped by A but just over rows 2,3 and 4.
DT[2:4, Total2:=sum(B), by=A]

# Remove the Total column
DT[, Total:=NULL]

# By the way, the R function [[ is useful to select a single column by name or number with the result returned 
# as a vector. Use [[ to select the third column.
DT[[3]]

# The second way to use := is a function form. The nice thing about a function form is that you can get each 
# right hand side (RHS) alongside the left hand side (LHS) so it is easier to read.

# Update B with B+1 and add a new column C with A+B, and D with constant 2.
DT[, `:=`(B=B+1,  C=A+B, D=2)]

# Given myCols = c("B","C"), delete those columns.
myCols = c("B","C")
DT[, (myCols):=NULL]  

# Delete column D by its number (2) rather than its name (D).
DT[, 2 := NULL]

# In the following two exercises, you will focus on the usage of set() and its siblings. Remember that set() 
# can not do grouped operations.

# Loop through columns 2,3 and 4, and for each one select 3 rows at random and set the value of that column to NA.
for (j in 2:4) {set(DT, j=j, i = sample(1:10, size=3), value = NA)}

# Change the column names to lower case. When setnames() is passed just one input vector, that needs to be all 
# the new names.
setnames(DT, names(DT), tolower(names(DT)))

# A wrap up of the set-family:
# set() is a loopable low overhead version of := 
# You can use setnames() to set or change column names
# setcolorder() lets you reorder the columns of a data.table

DT <- data.table(a=letters[c(1,1,1,2,2)], b=1)

# Add a postfix "_2" to all column names.
setnames(DT, names(DT), paste0(names(DT), "_2"))

# Change "a_2" to "A2" by names not position.
setnames(DT, "a_2", "A2")

# To end, reverse the order of the columns.
setcolorder(DT, c("b_2", "A2"))


# 3) Expert






