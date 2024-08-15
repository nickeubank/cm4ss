######################
# Load relevant data.
#
# Note that one dataset is
# a Stata format (file ends in .dta)
#
# All data imports are set to
# read data directly from the internet, so
# you won't have to install any files.
#
# To load Stata datasets, you need to load
# the package `haven`.
#
# Before you can load it, though, you will have to
# install it. In a normal project I would not include code to
# install a package since most packages you use you will install once
# and just load each time in the future, but
# here be sure to install it.
######################


# Load data on inequality (inequality.dta)

install.packages("statar")
install.packages("foreign")
library(foreign)
library(statar)


# Load Stata_FIPS.txt, which has codes to merge states with
# one another

fips_codes <- read.csv(
  paste0(
    "https://raw.githubusercontent.com/nickeubank/",
    "cm4ss/",
    "main/source/data/State_FIPS.txt"
  ),
  sep = "\t", header = TRUE
)

# Load data on taxation

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

inequality <- read.dta(paste0(
  "https://github.com/nickeubank/",
  "cm4ss/",
  "raw/main/source/data/inequality.dta"
))


######################
# Get to know the data
######################


# Check how many years of data are in inequality

table(inequality$year)

# Check how many years are in taxation.

table(taxation$year)

# See if we have all the states in taxation

table(taxation$name)
length(unique(taxation$name))


##############
# Clean up the data
##############

###
# Inequality
###

# Get relevant observations and variables from inequality

inequality <- inequality[, c("year", "state", "gini", "top10", "top1")]
inequality <- inequality[inequality$year == 2010, ]

# Get rid of entries that aren't states
table(inequality$state)

inequality <- inequality[(inequality$state != "District of Columbia") &
  (inequality$state != "United States"), ]


###
# Taxation
###

# Get relevant observations and variables from taxation

taxation <- taxation[, c(
  "year", "state", "Total.Taxes",
  "Total.Income.Taxes", "name"
)]


# Drop non-states from taxation
taxation <- taxation[taxation$name != "US STATE GOVTS", ]

# Get relevant observations and variables from populations

taxation <- taxation[taxation$year == 2010, ]

###
# Fips codes
###

# Only need names and fips codes
fips_codes <- fips_codes[, c("State.FIPS", "Name")]

# Don't want weird region lines and stuff
fips_codes <- fips_codes[fips_codes$State.FIPS != 11 &
  fips_codes$State.FIPS != 0, ]

###
# Population Data
###

populations <- populations[, c("NAME", "CENSUS2010POP")]

# Delete non-states:

populations <- populations[!(populations$NAME %in% c(
  "United States",
  "District of Columbia",
  "Puerto Rico",
  "Northeast Region",
  "Midwest Region",
  "South Region",
  "West Region"
)), ]



##############
# Merge the data!
##############

# Inequality and Taxation don't have a variable in common -- one uses
# state FIPS codes (the official US Census bureau state
# id number for each state)
# and one has state names as strings.
# So we need to merge taxation with our
# "cross-walk" dataset (called fips_codes)
# so we have both in one place.

fips_codes$state <- fips_codes[, "State.FIPS"]
fips_codes[, "State.FIPS"] <- NULL

taxation_w_names <- join(taxation, fips_codes,
  on = "state",
  kind = "full",
  check = 1 ~ 1,
  gen = "_merge"
)
stopifnot(taxation_w_names["_merge"] == 3)
taxation_w_names["_merge"] <- NULL


# Now we can merge inequality and taxation

inequality$Name <- inequality$state
inequality$state <- NULL


##########
# START SECRET CODE
##########

taxation_w_names[taxation_w_names["Name"] == "Hawai'i", "Name"] <- "Hawaii"
taxation_w_names[taxation_w_names["Name"] == "Rhode Isl.", "Name"] <- "Rhode Island"

##########
# END SECRET CODE
##########


ineq_and_taxation <- join(taxation_w_names, inequality,
  on = "Name",
  kind = "full",
  check = 1 ~ 1,
  gen = "_merge"
)

stopifnot(ineq_and_taxation["_merge"] == 3)
ineq_and_taxation["_merge"] <- NULL


# Now we can merge that data with populations!

populations$Name <- populations$NAME
populations$NAME <- NULL

full_data <- join(ineq_and_taxation, populations,
  on = "Name",
  kind = "full",
  check = 1 ~ 1,
  gen = "_merge"
)

stopifnot(full_data["_merge"] == 3)
full_data["_merge"] <- NULL

##############
# Analysis
#
# OK, enough hand-holding. Time for you to do your analysis!
#
# One hint: the comma in taxes may cause you problems.
# can you fix it?
# You may need `gsub`
##############
