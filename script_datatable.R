###############################
##### Script - data.table #####
###############################

# 1) Novice

library("data.table")

# Create your first data.table 
my_first_data_table <- data.table(x = c("a","b","c","d","e"), y = c(1,2,3,4,5))

# Create a data.table using recycling
DT <- data.table(a = 1:2, b = c("A", "B", "C", "D"))

# Print the third row to the console
DT[3,]

# Print the second and third row to the console, but do not use any comma at all
DT[2:3]

# Print the penultimate row of DT using `.N`
DT[.N-1]

# Print the column names of DT, and number of rows and number of columns
colnames(DT)
dim(DT)

# Select row 2 twice and row 3, returning a data.table with three rows where row 2 is a duplicate of row 1.
DT[c(2,2,3)]

# The data.table DT is still loaded in your workspace

# Print the penultimate row of DT using `.N`
DT[.N-1]

# Print the column names of DT, and number of rows and number of columns
colnames(DT)
dim(DT)

# Select row 2 twice and row 3, returning a data.table with three rows where row 2 is a duplicate of row 1.
DT[c(2,2,3)]

library("data.table")

# iris as data.table
DT <- as.data.table(iris)

# mean `Sepal.Length`
DT[,mean(Sepal.Length),by=Species]

# Group by the first letter
DT[,mean(Sepal.Length),by=substring(Species, 1, 1)]

library("data.table")
# The data.table DT is still loaded in your workspace

# Group the specimens by Sepal area (to the nearest 10 cm2) and count how many occur in each group.
DT[,.N, by=10*round(Sepal.Length*Sepal.Width/10)]

# Now name the output columns `Area` and `Count`
DT[,.(Count=.N), by=.(Area=10*round(Sepal.Length*Sepal.Width/10))]  

library("data.table")

# The data.table DT
set.seed(1L)
DT <- data.table(A=rep(letters[2:1], each=4L), B=rep(1:4, each=2L), C=sample(8))

# DT2
DT2 <- DT[, .(C=cumsum(C)), by=.(A,B)]

# Now the last two values per grouping in A from C in DT2 while you group by A
DT2[, .(C=tail(C,2)), by=A] 

library("data.table")

# The data.table DT
set.seed(1L)
DT <- data.table(A=rep(letters[2:1], each=4L), B=rep(1:4, each=2L), C=sample(8))

# DT2
DT2 <- DT[, .(C=cumsum(C)), by=.(A,B)]

# Now the last two values per grouping in A from C in DT2 while you group by A
DT2[, .(C=tail(C,2)), by=A] 

# Get the median of all the four columns Sepal.Length, Sepal.Width, Petal.Length and Petal.Width while 
# you group by Species. Give them the same names. Next, order Species in descending order using chaining.

DT <- data.table(iris)

DT[, .(Sepal.Length=median(Sepal.Length), Sepal.Width=median(Sepal.Width), Petal.Length=median(Petal.Length), Petal.Width=median(Petal.Width)), by=Species][order(Species, decreasing = TRUE)]

# Mean of columns

DT[, lapply(.SD, mean), by=x]

# Median of columns
DT[, lapply(.SD, median), by=x]

# Calculate the sum of the Q columns
DT[, lapply(.SD, sum), .SDcols=2:4]

# Calculate the sum of columns H1 and H2 
DT[,lapply(.SD,sum), .SDcols=paste0("H",1:2)]

# Select all but the first row of groups 1 and 2, returning only the grp column and the Q columns. 
DT[,.SD[-1], by=grp, .SDcols=paste0("Q",1:3)]



# The data.table DT is loaded in your workspace
desired_result_1
desired_result_2

# Sum of all columns and the number of rows
DT[, c(lapply(.SD, sum), .N), by=x, .SDcols=c("x", "y", "z")]

# Cumulative sum of column `x` and `y` while grouping by `x` and `z > 8`
DT[, lapply(.SD, cumsum),by=.(by1=x, by2=z>8), .SDcols=c("x", "y")]

# Chaining
DT[, lapply(.SD, cumsum),by=.(by1=x, by2=z>8), .SDcols=1:2][, lapply(.SD, max), by=by1, .SDcols=c("x", "y")]



# The data.table DT is loaded in your workspace
desired_result_1
desired_result_2

# Sum of all columns and the number of rows
DT[, c(lapply(.SD, sum), .N), by=x, .SDcols=c("x", "y", "z")]

# Cumulative sum of column `x` and `y` while grouping by `x` and `z > 8`
DT[, lapply(.SD, cumsum),by=.(by1=x, by2=z>8), .SDcols=c("x", "y")]

# Chaining
DT[, lapply(.SD, cumsum),by=.(by1=x, by2=z>8), .SDcols=1:2][, lapply(.SD, max), by=by1, .SDcols=c("x", "y")]



# The data.table DT is loaded in your workspace
desired_result_1
desired_result_2

# Sum of all columns and the number of rows
DT[, c(lapply(.SD, sum), .N), by=x, .SDcols=c("x", "y", "z")]

# Cumulative sum of column `x` and `y` while grouping by `x` and `z > 8`
DT[, lapply(.SD, cumsum),by=.(by1=x, by2=z>8), .SDcols=c("x", "y")]

# Chaining
DT[, lapply(.SD, cumsum),by=.(by1=x, by2=z>8), .SDcols=1:2][, lapply(.SD, max), by=by1, .SDcols=c("x", "y")]


set.seed(1)

# Check the DT that is made available to you
DT

# For loop with set
for (j in 2:4) {set(DT, j=j, i = sample(1:10, size=3), value = NA)}

# Change the column names to lowercase
setnames(DT, names(DT), tolower(names(DT)))

# Print the new DT to the console so we can check your answer
DT


DT <- data.table(a=letters[c(1,1,1,2,2)], b=1)

# Postfix "_2"
setnames(DT, names(DT), paste0(names(DT), "_2"))

# "a_2" to "A2"
setnames(DT, "a_2", "A2")

# Reversing order
setcolorder(DT, c("b_2", "A2"))


DT <- data.table(a=letters[c(1,1,1,2,2)], b=1)

# Postfix "_2"
setnames(DT, names(DT), paste0(names(DT), "_2"))

# "a_2" to "A2"
setnames(DT, "a_2", "A2")

# Reversing order
setcolorder(DT, c("b_2", "A2"))


# The data.table iris is already loaded in your workspace
iris

# Area is greater than 20 square centimeters
iris[Length*Width > 20]

# Add new boolean column
iris[,IsLarge:=Length*Width > 20]

# Now select rows again where the area is greater than 20 square centimeters
iris[IsLarge==TRUE]


# This is your data.table `DT`. The keys are set to `A` and `B`
DT <- data.table(A=letters[c(2,1,2,3,1,2,3)], B=c(5,4,1,9,8,8,6), C=6:12)
setkey(DT,A,B)

# Select the `b` group
DT["b"] 

# `b` and `c` groups
DT[c("b","c")]

# The first row of the `b` and `c` group
DT[c("b","c"), mult="first"]

# `by=.EACHI` and `.SD` 
DT[c("b","c"), .SD[c(1,.N)], by=.EACHI]

# Print out all the data in the two groups before you return the first and last row of each group again.  Use {} and .N 
DT[c("b","c"), {print(.SD);.SD[c(1,.N)]}, by=.EACHI]


# The data.table DT is still loaded in your workspace
library("data.table")

# Key of `DT`
key(DT)

# Row where  `A=="b"` & `B==6`
DT[.("b",6)]

# Return the prevailing row
DT[.("b",6), roll=TRUE]

# Nearest one
DT[.("b",6), roll="nearest"]


# The data.table DT is still loaded in your workspace


# Look at the sequence (-2):10 for the `b` group
DT[.("b",(-2):10)]

# Carry the prevailing values forwards
DT[.("b",(-2):10),  roll=TRUE]

# Carry the first observation backwards
DT[.("b",(-2):10), roll=TRUE, rollends=TRUE]
# or
DT[.("b",(-2):10), roll = TRUE, rollends= c(TRUE,TRUE)]

# Roll for a distance of 2
DT[.("b",(-2):10), roll=2]







