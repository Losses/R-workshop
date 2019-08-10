################################################################################
#
#  CHARAPTER 2
#
#  FLOW CONTROL
#
################################################################################

#-------------------------------------------------------------------------------
# SECTION 1: CONDITION, LOOP, AND FUNCTION
#-------------------------------------------------------------------------------

# 1.1 CONDITION
#~~~~~~~~~~~~~~~

# If some condition meets, run a specific block of code is a common sence while
# coding, like other languages, R use the following structure to express the 
# condition branch.

sub_in_love <- 'inLove'

if (sub_in_love == 'inLove') {
  print('yes')
} else {
  print('no')
}

# Or

if (sub_in_love == 'inLove') {
  print('yes')
}

# In R, we can also use the function 'ifelse' to make it more expressive:

ifelse(sub_in_love == 'inLove', 'yes', 'no')

# 1.2 BASIC LOOP
#~~~~~~~~~~~~~~~~

# We can iterate through each element in a vector in this way:

for ( i in 1:5 ) {
  print(i)
}

#*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*
# BUT PLEASE NOTICE: THIS TRAVERSAL METHOD IS VERY INEFFICIENT, IT'S HIGHLY    |
# RECOMMENDED NOT USING "FOR" IN THE CASE OF LARGE DATA OPERATIONS, LIKE FMRI  *
# DATA!                                                                        |
#*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*

# 1.3 FUNCTION
#~~~~~~~~~~~~~~

# Defining frequently used codes as a function is a good practice which can
# increase the maintainability and readabilitys of our code, let's try defining
# a simple function, to say hello to someone:

say_hello <- function(x) {
  paste0('Hello, ', x, '!') 
}

# and call it:

say_hello('Mike')

#-------------------------------------------------------------------------------
# SECTION 2: ADVANCED LOOP
#-------------------------------------------------------------------------------

# In the world of R, a more efficient way to travers variables is functional
# loop, there are a lot function to help us finish different type of task, the 
# basic idea of functional loop is defining a function, the traverse function 
# will pass each element as a parameter to the function you defined.

# we'll introduce three most used functions in psychology research here:

# 2.1 LAPPLY
#~~~~~~~~~~~~

# Lapply will travers each element of the specific variable, and return a list of
# returned result.

# Say, we want to say hello to a lot of people:

members <- c('Alice', 'Mike', 'Joe', 'Tony')
lapply(members, say_hello)

# Or report the SCL-90 scores of different members:

scores <- list(
  list(name = 'Alice', score = 90),
  list(name = 'Mike', score = 100),
  list(name = 'Joe', score = 70)
)

lapply(scores, function(x) {
  paste0('The SCL90 score of ', x$name, ' is ', x$score, '.')
})

# 2.2 SAPPLY
#~~~~~~~~~~~~

# Sapply is a simplified version of `lapply`, it will try to return a vector
# if it's possible.

sapply(members, say_hello)

sapply(scores, function(x) {
  paste0('The SCL90 score of ', x$name, ' is ', x$score, '.')
})

# Some programmers object to using this function because the type of result it 
# returns is indeterminate (list or vector), which affects the robustness of the
# program. However, for some specific scenarios sapply is a more efficient way 
# to solve our problem.

# 2.3 MAPPLY
#~~~~~~~~~~~~

# Mapply accepts multiple variables of equal length and sequentially passes each 
# element of these variables to our function.

# Say, if we have a lot of patients, and someone asked us to generate a list to
# guide the visitors to their ward.

research_cases <- data.frame(
  case_id = c(30, 35, 10, 12),
  bleeding = c(T, T, T, T),
  surgery = c(T, F, T, F),
  name = I(c('Hao', 'Si', 'Yang', 'Na'))
)

query_patient_room <- function(name, bleeding, surgery) {
  room_type <- ifelse(bleeding && !surgery, 'ICU ward', 'General ward')
  paste0('Please meet ', name, ' in the ', room_type, '.')
}

mapply(
  query_patient_room, 
  research_cases$name, 
  research_cases$bleeding, 
  research_cases$surgery
)

#-------------------------------------------------------------------------------
# SECTION 3: ADVANCED FLOW CONTROL
#-------------------------------------------------------------------------------

# 3.1 PIPELINE OPERATOR
#~~~~~~~~~~~~~~~~~~~~~~~

# Pipeline operator is a very convenient way to simplify our code. Say, we want 
# to transform the MNI coordinate to AAL region name, we need to:

# * Load the library we need to use:

library(mni2aal)

# * Load the data we want to use:

coordinates = read.csv('./data/MNI_coordinates.csv')

#   Let's inspect the data to make sure R read it properly:

coordinates

# * Transform each coordinate to AAL region name:

aal_names_list <- mapply(
  mni_to_region_name, 
  coordinates$x, 
  coordinates$y, 
  coordinates$z
)

# * It's not enough, because is not structured, this will cause a lot of 
#   inconvinent while further data analysis, so let's convert the result to
#   a data frame:

#   - Rotate the list, it will turn the list to a row-wise matrix:

aal_names_long_matrix <- t(aal_names_list)

#   - Turn the matrix to a data frame:

aal_names_df <- as.data.frame(aal_names_long_matrix)

#   - Combine the result with original data frame:

cbind(coordinates, aal_names_df)

# We created a lot of tempory variables, each variable consumes a certain amount
# of memory. While analysis a bunch of data (like 10K+), unnecessary memory 
# consumption is very very "impressive", to avoid this, we can write the code
# in this way:

cbind(
  coordinates, 
  as.data.frame(
    t(
      mapply(
        mni_to_region_name,
        coordinates$x,
        coordinates$y,
        coordinates$z
      )
    )
  )
)

# But wait! PARENTHESES HELL! No humans can understand what the code does, the 
# code looks like a pasta twist!

# The pipeline operator in the `tidyverse` library(or `magrittr`, a sub library
# of `tidyverse``) can aid this situation.

# Let's load the library firstly:

library(tidyverse)

# and clean our code:

mapply(mni_to_region_name, coordinates$x, coordinates$y, coordinates$z) %>% 
  t %>%
  as.data.frame %>% 
  cbind(coordinates, .)

# the pipeline opreator will pass the calculating result on the left side to 
# the function on the right side, if not specified, the result will appear as 
# the first parameter, we can write a '.' on any place to change where to put the
# result (see the last line of example code).