#################################
##### Quandl - A first date #####
#################################

# Hello, and welcome to this interactive tutorial on how to use Quandl with R. If you are not familiar 
# with Quandl, Quandl is like a Google for numerical data to find and use numerical data easily and fast. 
# It is an open platform, that wants to offer everyone a rich collection of high quality numerical data on 
# thousands of subjects.

# The cool thing of Quandl is that every single dataset is available via the API, irrespective of where or 
# how or in what format the data was originally published. You can do up to 50 anonymous API calls per day, 
# and 500 if you are a signed-in user.

# In this tutorial you will look at how to use Quandl within your favorite statistical language: R! Quandl 
# is available as an R package on CRAN so you have all the power of the Quandl API directly in your R console.

# 1) Load the Quandl package with the help of library().
library(Quandl)

# 2) Load your dataset NSE/OIL with the Quandl() function, and assign it to the variable mydata. For now, 
# don't worry about the format.
mydata <- Quandl("NSE/OIL")

# At Quandl, every dataset is identified by a unique id. This unique id can be found on the Quandl website 
# as the Quandl Code. For example, the Quandl page for Twitter shows that the Quandl code to fetch this data 
# is GOOG/NYSE_TWTR. You use this ID to access your dataset in R. 

# 3) Look up the code for the Prague Stock Index and access it in R by assigning the dataset to PragueStockExchange. 
# You can find the Quandl code to do so on the website.
PragueStockExchange = Quandl("PRAGUESE/PX")

# The Quandl package is able to return data in 4 very usable formats:
# data frame ("raw"),
# ts ("ts"),
# zoo ("zoo") and
# xts ("xts")

# The only thing you have to do is give the type you want as an argument to the Quandl() function.
# Suppose you want to plot the stock price of Facebook (Use Quandl code: GOOG/NASDAQ_FB), with the help of the 
# quantmod package. This package requires you to use the xts format.

# 4) Assign the Facebook stock quotes to the variable Facebook. Do not forget to indicate to use the xts type.
Facebook <- Quandl("GOOG/NASDAQ_FB", type="xts")

# 5) The quantmod package is already loaded. Use candleChart to plot the graph.
library(quantmod)
candleChart(Facebook)


# Obviously, you do not want to go to the Quandl website every single time you need a dataset in R. Luckily, 
# it is possible to search Quandl datasets using R as follows:
Quandl.search(query = "Search Term", page = int, source = "Specific source to search", silent = TRUE|FALSE)

# query is the only mandatory argument and represents the term you wish to search for on Quandl. page is which 
# page of search result you wish to return (default = 1), and source lets you choose the specific source you 
# wish to search for. By putting silent to FALSE you see the first 3 results printed to the console. If silent 
# is set to TRUE it does not print anything to screen.
# What if you want to see all search results on the first page? You can assign the result of the Quandl.search() 
# function to a variable, and then print this variable to find out about all search results.


# Given the recent popularity of Bitcoins, you want to do a search for Bitcoin. You only want the first 3 results 
# from the first page. You have no idea on what specific source to search for so there's no need to use the source 
# parameter. Assign the result of this search to the variable results.
results <- Quandl.search(query="Bitcoin", silent=FALSE)

# Print out the results in a structured manner using the str() function.
str(results)

# Assign the data set related to the fourth search result, corresponding to the code "BCHAIN/TOTBC", to the 
# variable BitCoin.
BitCoin <- Quandl("BCHAIN/TOTBC")

# In this second and final chapter you will have a look at how you can manipulate Quandl's datasets before you 
# start working with them.
# The Quandl() function has two arguments start_date and end_date, that can be used to specify the time range 
# of the data to load. The format to specify the date is: yyyy-mm-dd.

# Assign to the variable Exchange the USD/EUR exchange rate from January 1st 2013 up to December 1st 2013. 
# The code to pass to the Quandl() function is "BNP/USDEUR".
Exchange <- Quandl("BNP/USDEUR", start_date="2013-01-01", end_date="2013-12-01")

# Quandl can transform your data before serving it. You can set the transformation argument to:
# "diff"
# "rdiff"
# "cumul", and
# "normalize".
# Have a look at the Quandl API documentation to see what these options actually do.

# You want to know the Canadian GDP annual percent change. Use the rdiff transformation and assign the result 
# to GDP_Change. Use the code "FRED/CANRGDPR"; more information can be found on Quandl's website.
GDP_Change <- Quandl("FRED/CANRGDPR", transformation="rdiff")

# You don't always need every available data tick for your analysis. Sometimes having the data available on 
# a daily or weekly base is sufficient. By altering the collapse parameter you can easily indicate the desired 
# frequency. The available options are: none|daily|weekly|monthly| quarterly|annual
# Quandl returns the last observation for the given period. So, if you collapse a daily dataset to “monthly”, 
# you will get a sample of the original dataset where the observation for each month is the last data point 
# available for that month.

# Get crude oil prices on a quarterly basis from the EIA's daily spot price (DOE/RWTC) and assign these to the 
# variable eiaQuarterly.
eiaQuarterly <- Quandl("DOE/RWTC", collapse="quarterly")

# Two other arguments of the Quandl() function are rows and sort.
# The meaning of sort is straightforward, and by default it is set on descending.
# The rows argument on the other hand allows you to get only the first n rows of your query. For example, you 
# can use rows=1 to get the latest observation of any dataset.

# You only want the first 5 observations of the crude oil prices from the EIA (DOE/RWTC) in an ascending order. 
# The result should be assigned to TruSo.
TruSo <- Quandl("DOE/RWTC", rows=5, sort="asc")
TruSo


# For this final exercise you will be really challenged. This time you need to combine multiple parameters to 
# show you are worthy of calling yourself a true Quandl expert.
# You want to have the daily percent change in oil prices from January 2005 to March 2010, in ascending order.

Final <- Quandl("DOE/RWTC", start_date = "2005-01-01", end_date = "2010-03-01", 
                sort = "asc", transformation = "rdiff")


