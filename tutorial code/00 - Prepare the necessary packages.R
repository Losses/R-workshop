################################################################################
#
#  CHARAPTER 0
#
#  PREPARE THE NECESSARY PACKAGES
#
################################################################################

# Welcome to *The Brief Introduction to R*, to make sure. To ensure the talk 
# goes smoothly, please prepare some packages before the talk.

# Packages are an integral part of the R language ecosystem, to install some 
# packages, we can use the function: `install.packages()`.

# We can install multiple packages at once, with `install.packages(c(...))`.

install.packages(c('devtools', 'tidyverse'))

# And to load the packages we just install, we use `library()`

library('devtools')

# Finally, run this code to install packages from github.

install_github("yunshiuan/label4MRI",subdir = "label4MRI")
