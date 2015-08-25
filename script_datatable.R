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





