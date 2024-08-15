#####
# Session Setup: Loading, familiarizing
#####

library(statar)

inequality <- read.dta(paste0(
  "https://github.com/nickeubank/",
  "cm4ss/",
  "raw/main/source/data/inequality.dta"
))

table(inequality$year)

table(taxation$year)

head(populations)

head(taxation)

install.packages("foreign")

fips_codes <- read.csv(
  paste0(
    "https://raw.githubusercontent.com/nickeubank/",
    "cm4ss/",
    "main/source/data/State_FIPS.txt"
  ),
  sep = "\t", header = TRUE
)

library(foreign)

head(inequality)

install.packages("statar")

table(taxation$name)

length(unique(taxation$name))

taxation <- read.csv(paste0(
  "https://raw.githubusercontent.com/nickeubank/",
  "cm4ss/",
  "main/source/data/STC_Historical_taxes.csv"
))

populations <- read.csv(paste0(
  "https://raw.githubusercontent.com/nickeubank/",
  "cm4ss/",
  "main/source/data/state_populations.csv"
))

#####
# Data Cleaning
#####

populations <- populations[!(populations$NAME %in% c(
  "United States",
  "District of Columbia",
  "Puerto Rico",
  "Northeast Region",
  "Midwest Region",
  "South Region",
  "West Region"
)), ]

taxation <- taxation[taxation$name != "US STATE GOVTS", ]

inequality <- inequality[(inequality$state != "District of Columbia") &
  (inequality$state != "United States"), ]


populations$state <- populations$NAME
populations$NAME <- NULL

populations$population_2010 <- populations$CENSUS2010POP
populations$CENSUS2010POP <- NULL

inequality <- inequality[, c("year", "state", "gini", "top10", "top1")]

taxation <- taxation[, c(
  "year", "state", "Total.Taxes",
  "Total.Income.Taxes", "name"
)]

fips_codes <- fips_codes[fips_codes$State.FIPS != 11 &
  fips_codes$State.FIPS != 0, ]

fips_codes <- fips_codes[, c("State.FIPS", "Name")]

inequality <- inequality[inequality$year == 2010, ]

table(inequality$state)

taxation <- taxation[taxation$year == 2010, ]

populations <- populations[, c("NAME", "CENSUS2010POP")]


##############
# Merge the data!
#
# Note that if any of your merge validation
# checks fail, you will need to ADD code
# you write yourself to fix the issues.
#
# Also, not that in the merge commands below,
# I've just put in `FILL_IN` for fields you
# need to complete.
##############

fips_codes$state <- fips_codes[, "State.FIPS"]
fips_codes[, "State.FIPS"] <- NULL

stopifnot(taxation_w_names["_merge"] == 3)
taxation_w_names["_merge"] <- NULL

ineq_and_taxation <- join(taxation_w_names, inequality,
  on = "FILL_IN",
  kind = "FILL_IN",
  check = FILL_IN,
  gen = "_merge"
) # NOTE: You have to replace `FILL_IN` with appropriate content in this func

inequality$Name <- inequality$state
inequality$state <- NULL

stopifnot(full_data["_merge"] == 3)
full_data["_merge"] <- NULL

full_data <- join(ineq_and_taxation, populations,
  on = "FILL_IN",
  kind = "FILL_IN",
  check = FILL_IN,
  gen = "_merge"
) # NOTE: You have to replace `FILL_IN` with appropriate content in this func

stopifnot(ineq_and_taxation["_merge"] == 3)
ineq_and_taxation["_merge"] <- NULL

taxation_w_names <- join(taxation, fips_codes,
  on = "FILL_IN",
  kind = "FILL_IN",
  check = FILL_IN,
  gen = "_merge"
) # NOTE: You have to replace `FILL_IN` with appropriate content in this func

populations$Name <- populations$NAME
populations$NAME <- NULL
