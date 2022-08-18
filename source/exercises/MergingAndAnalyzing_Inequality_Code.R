

#####
# Session Setup: Loading, familiarizing
#####


library(statar)

inequality <- read.dta(paste0(
    "https://github.com/nickeubank/",
    "computational_methods_boot_camp/",
    "raw/main/source/data/inequality.dta"
))

table(inequality$year)

table(taxation$year)

head(populations)

head(taxation)

install.packages("foreign")

fips_codes <- read.csv(paste0(
    "https://raw.githubusercontent.com/nickeubank/",
    "computational_methods_boot_camp/",
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
    "computational_methods_boot_camp/",
    "main/source/data/STC_Historical_taxes.csv"
), )

populations <- read.csv(paste0(
    "https://raw.githubusercontent.com/nickeubank/",
    "computational_methods_boot_camp/",
    "main/source/data/state_populations.csv"
))

#####
# Data Cleaning
#####

populations <- populations[!(populations$state %in% c(
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


populations <- rename(populations,
    state = NAME,
    population_2010 = CENSUS2010POP
)

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
##############


full_data <- join(ineq_and_taxation, populations,
    by.x = "FILL_IN_CORRECT_VALUE_HERE",
    by.y = "FILL_IN_CORRECT_VALUE_HERE",
    kind = "outer"
)


ineq_and_taxation <- join(taxation_w_names, inequality,
    by.x = "FILL_IN_CORRECT_VALUE_HERE",
    by.y = "FILL_IN_CORRECT_VALUE_HERE",
    kind = "outer"
)

taxation_w_names <- join(taxation, fips_codes,
    by.x = "FILL_IN_CORRECT_VALUE_HERE", by.y = "FILL_IN_CORRECT_VALUE_HERE",
    kind = "outer"
)
