################################################################################
#
#  CHARAPTER 1
#
#  TYPE SYSTEM
#
################################################################################

#-------------------------------------------------------------------------------
# SECTION 1: VECTOR
#-------------------------------------------------------------------------------

# 1.1 CREATING VECTOR
#~~~~~~~~~~~~~~~~~~~~~

# Vector is the most basic variable type in the world of R. Each vector contains
# one or multiple atominc elements, like:
# Numeric:

1

# Character:

"Hello; World!"
'Healthy Apple!'

# Logical:

TRUE
FALSE
T
F

# We can create a vectpr using the function: c():

c(1, 2, 3, 4, 5)
c('CS', 'STS', 'TPJ')
c(T, F, F, T, F)

# A convinent way to create a sequence is:

1:5

# It is equivalent to `c(1, 2, 3, 4, 5)`.

# And, we can assign the vector to a variable in the following fashion:

temp_var <- 1:5
c(T, F, F, T, F) -> temp_var
temp_var = c('CS', 'STS', 'TPJ')

# It's highly recommended to use the first way to assign a varibale, for more
# detail, checkout https://google.github.io/styleguide/Rguide.xml

# Now, you can inspect your variable by:

temp_var

# 1.2 QUERYING VECTOR
#~~~~~~~~~~~~~~~~~~~~~

# How can we get one or more elements from a vector?
# To get a single element:

temp_var[0]

# To get multiple elements:

temp_var[1:2]
temp_var(c(1, 2))
temp_var(c(F, T, T))

# 1.3 OPERATING VECTOR
#~~~~~~~~~~~~~~~~~~~~~~

# We can try some basic mathematical calculations:

1 + 1    # Addition
2 - 1    # Subtraction
1 * 2    # Multiplication
1 / 5    # Division
10 %% 3  # Modulus
10 %/% 3 # Integer divide

# And we can operating logical vector with following operators:

T & F                   # And
T | F                   # Or
c(T, T, T) & c(T, F, T)
c(T, T, F) | c(T, T, T)

# In the world of R, we can also use operator to operate each element in a 
# vector with the following code: 

c(1, 2, 3, 4, 5) + 2
1:5 * 2:6
c(F, F, T) * 2


#-------------------------------------------------------------------------------
# SECTION 2: FACTOR
#-------------------------------------------------------------------------------

# Factor is a special kind of vector, we call it **compound vector**, It 
# corresponds to the concept of **nominal variables** in statistics.

# Say, there are five members in a team, and we want to list their gender, 
# using factor is a good choice.

gender <- factor(c('male', 'male', 'female', 'male', 'female'))
gender

# Factor is made up of values and levels, to inspect values, we can run 
# following code:

as.numeric(gender)

# and to inspect levels, we can:

levels(gender)

# R will map levels to values and return the factor vector, it's necessary
# while we are facing a bunch of data, using character vector may consume
# a lot of memory, and potential data mistake may not easy to be checked out.

#-------------------------------------------------------------------------------
# SECTION 3: LIST
#-------------------------------------------------------------------------------

# 3.1 CREATING LIST
#~~~~~~~~~~~~~~~~~~~

# Why list? Try the following code:

c(2.2, 'Frontal Lobe', T, 1)

# You will get a character vector, because R require each element in a vector 
# must have the same type, if the types are not consistent, it will try to 
# convert them, that's a pitfall while programming using R.

# To solve this problem, we can use list. Now, let's create a list:

list(2.2, 'Frontal Lobe', T, 1)

# If we want to store different types of variable in a single object, we should
# consider using list.

# Each element of a list has a name(or index) and its value, in the example 
# above, `[[1]]` is the index and `[1] 2.2` is the value.

# We can also create list with element name:

sub <- list(oxytocin = 2.2, peak_aal = 'Frontal Lobe', in_love = T, group = 1)

# 3.2 QUERYING LIST
#~~~~~~~~~~~~~~~~~~~

# We can get the **value** of each element in this fashion:

sub[[1]]
sub[['oxytocin']]
sub$oxytocin
sub$`oxytocin`

# And if you want to get a sublist, we can:

sub['oxytocin']
sub[c('oxytocin', 'group')]

#-------------------------------------------------------------------------------
# SECTION 4: DATA FRAME
#-------------------------------------------------------------------------------

# 4.1 CREATING DATA FRAME
#~~~~~~~~~~~~~~~~~~~~~~~~~

# It's a quite common requirement to list different types of information in a 
# table, data frame can help us to finish the task.

# To create a data frame, we use the function: `data.frame()`

research_cases <- data.frame(
  case_id = c(30, 35, 10, 12),
  bleeding = c(T, T, T, T),
  surgery = c(T, F, T, F),
  name = c('Hao', 'Si', 'Yang', 'Na')
)

research_cases

# Now, we've created a data frame with two rows and four columns.

# Data frame has some notable features:

# * LENGTH: The length of each column must be consistent, running the following
#           code will cause an error.

data.frame(
  case_id = c(30, 35, 10, 12),
  bleeding = c(T, T, T),
  surgery = c(T, F, T),
  name = c('Hao', 'Si', 'Yang')
)

# * BROADCASTING: If not consistent, R will try to broadcast the data 
#                 automatically;

data.frame(
  case_id = c(30, 35, 10, 12),
  bleeding = c(T),
  surgery = c(T, F),
  name = c('Hao', 'Si', 'Yang')
)

# * SPECIAL LIST: Data frame is a kind of **compound list**, it means that data
#                 frame shares a lot of feature with list, like querying method.

as.list(research_cases)

# * CHARACTER TO FACTOR: The character vector will be transformed to factor 
#                        vector while creating the data.frame.

class(research_cases$name)

#                        sometimes you may want to keep it as character, we can:

research_cases$name <- as.character(research_cases$name)

#                        or

library(magrittr)

research_cases$name %<>% as.character

#                        Let's inspect it's class now:

class(research_cases$name)

# 4.2 QUERYING DATA FRAME
#~~~~~~~~~~~~~~~~~~~~~~~~~

# To get the **value** of specific column, we can:

research_cases[['name']]
research_cases$name
research_cases$`name`

# To get a sub data frame, we use single brackets. Say, if we want to get 
# specific column or multiple columns:

research_cases[1]
research_cases[1:2]
research_cases[, 1]
research_cases[, 1:2]

# To get specific columns and rows:

research_cases[1, 1:2]
research_cases[2:3, 1:2]
research_cases[1:3, c('surgery', 'name')]

# To get rows:

research_cases[1:2, ]

# PLEASE NOTICE THAT: If you are trying to query values from a single row,
# R will return its value but not a sub data frame.

research_cases[1, 1]
research_cases[2:4, 1]
research_cases[2:4, 'bleeding']

# 4.3 OPERATING DATA FRAME
#~~~~~~~~~~~~~~~~~~~~~~~~~~

# Sometimes, we may get data fragment from different source, to analysis the data
# combining them is necessary.

# To combine the data row by row, we can use `rbind()`:

research_cases_1 <- data.frame(
  case_id = c(30, 35),
  bleeding = c(T, T),
  surgery = c(T, F),
  name = c('Hao', 'Si')
)
research_cases_2 <- data.frame(
  case_id = c(10, 12),
  bleeding = c(T, T),
  surgery = c(T, F),
  name = c('Yang', 'Na')
)

rbind(research_cases_1, research_cases_2)

# To combine the data column by column, we can use `cbind()`:

research_cases_1 <- data.frame(
  case_id = c(10, 12, 16),
  name = c('Yang', 'Na', 'DanDan')
)

research_cases_2 <- data.frame(
  surgery = c(F, F, T),
  bleeding = c(T, T, F)
)

cbind(research_cases_1, research_cases_2)

# The data from different source may have different row order, to merge them 
# correctly, we have to use `merge()`:

research_cases_names <- data.frame(
  case_id = c(15, 16, 10, 12),
  name = c('MuDan', 'DanDan', 'Yang', 'Na')
)
research_cases_detail <- data.frame(
  case_id = c(10, 12, 15, 16),
  surgery = c(F, F, F, T),
  bleeding = c(T, T, F, F)
)

merge(research_cases_names, research_cases_detail, by = 'case_id')

# For advanced data operating and cleaning, tidyverse may help a lot, to get 
# more detail, please visit: https://www.tidyverse.org/packages/
