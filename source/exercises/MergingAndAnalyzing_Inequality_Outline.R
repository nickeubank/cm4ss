######################
# Load relevant data.
#
# Note that one dataset is
# a Stata format (file ends in .dta)
#
# To load Stata datasets, you need to load
# the package `foreign`.
#
# Before you can load it, though, you will have to
# install it. In a normal project I would not include code to
# install a package since most packages you use you will install once
# and just load each time in the future, but
# here be sure to install it.
######################

######################
# Get to know the data
######################


# Check how many years of data are in inequality

# Check how many years are in taxation.

# See if we have all the states in taxation
# (two commands to get full picture)

##############
# Clean up the data
##############

###
# Inequality
###

# Get relevant observations and variables from inequality

# Get rid of entries that aren't states
# (no district of columbia, puerto rico, regions, divisions,
# US STATE GOVTS, or "United States")

###
# Taxation
###

# Get relevant observations and variables from taxation

# Drop non-states from taxation
# (no district of columbia, puerto rico, regions, divisions,
# US STATE GOVTS, or "United States")

# Get relevant observations and variables from populations

# Get rid of non-states
# (no district of columbia, puerto rico, regions, divisions,
# US STATE GOVTS, or "United States")


###
# Fips codes
###

# Only need names and fips codes

# Don't want weird region lines and stuff
# (no district of columbia, puerto rico, regions, divisions,
# US STATE GOVTS, or "United States")

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

# Inequality and Taxation don't have a variable in common -- one uses
# state FIPS codes (the official US Census bureau state
# id number for each state)
# and one has state names as strings.
# So we need to merge taxation with our
# "cross-walk" dataset (called fips_codes)
# so we have both in one place.

####
# Now we can merge inequality and taxation.
####


###
# Now merge with inequality
###


###
# Now we can merge that data with populations!
###



##############
# Analysis
#
# OK, enough hand-holding. Time for you to do your analysis!
#
# One hint: the comma in taxes may cause you problems.
# can you fix it?
# You may need `gsub`
#
# To run a linear regression, use `lm()`.
# Examples here: https://www.datacamp.com/tutorial/linear-regression-R
##############
