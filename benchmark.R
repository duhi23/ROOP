## BIG DATA TESTS --------------------------------------------------------------
#' Versions:
#' dplyr: 0.1.2
#' data.table: 1.9.2
#' microbenchmark: 1.3-0


require(dplyr)
require(data.table)
require(microbenchmark)
require(RSQLite)
require(RSQLite.extfuns)


## Create data -----------------------------------------------------------------

# Vars
index = c(1:5000000)
class = sample(letters[1:10], 5000000, replace = TRUE)
class2 = sample(50, 5000000, replace = TRUE)
randomletters = sapply(1:5000000, function(i) paste(c(letters, LETTERS, 0:9)[sample(62, 10, replace=TRUE)], collapse=""))
randomnumber = runif(5000000, -10, 10)

# data.table
bigDT <- data.table(
      index = index,
      class = class,
      class2 = class2,
      randomletters = randomletters,
      randomnumber = randomnumber
)


# dplyr
bigTBL <- tbl_df(data.table(
      index = index,
      class = class,
      class2 = class2,
      randomletters = randomletters,
      randomnumber = randomnumber
))

# dplyr PostgreSQL
SQLitedb <- src_sqlite("big_db.sqlite", create = TRUE)
bigSQL <- copy_to(SQLitedb, bigDT, temporary = FALSE, indexes = list("index"))


## Benchmarks ------------------------------------------------------------------

# Select one column (horizontal filtering)
select_benchmark <- microbenchmark(
      onecol_dt = bigDT[,list(class)],
      onecol_dpl = select(bigTBL, class),
      
      times = 20L,
      control = list(warmup = 5)
)

# Select by criterion (vertical filtering)

filter_benchmark <- microbenchmark(
      filter_dt = bigDT[class2 == 1],
      filter_dpl = filter(bigTBL, class2 == 1),
      
      times = 20,
      control = list(warmup = 5)
)

# Compound filtering

multifilter_benchmark <- microbenchmark(
      multifilter_dt = bigDT[class2 == 1 & class == "b", list(index, randomletters, randomnumber)],
      multifilter_dpl = select(filter(bigTBL, class2 == 1, class == "b"), index, randomletters, randomnumber),
      
      times = 20,
      control = list(warmup = 5)
)

# Summarization

summarize_benchmark <- microbenchmark(
      summarize_dt = bigDT[class2 %in% 1:5 & class != "b", list(mean = mean(randomnumber)), by = "class"],
      summarize_dpl = summarise(
            group_by(
                  select(
                        filter(bigTBL, class2 %in% 1:5, class != "b"),
                        class, randomnumber
                  ),
                  class
            ),
            mean = mean(randomnumber)
      ),
      #    summarize_sql = print(summarise(
      #       group_by(
      #          select(
      #             filter(bigSQL, class2 %in% 1:5, class != "b"),
      #             class, randomnumber
      #          ),
      #          class
      #       ),
      #       mean = mean(randomnumber)
      #    )),
      
      times = 20,
      control = list(warmup = 5)
)