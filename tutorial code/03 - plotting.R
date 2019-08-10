################################################################################
#
#  CHARAPTER 3
#
#  DATA I/O AND PLOTTING
#
################################################################################

#-------------------------------------------------------------------------------
# SECTION 1: DATA I/O
#-------------------------------------------------------------------------------

# 1.1 READING DATA
#~~~~~~~~~~~~~~~~~~

# We can use `read.csv()` to read data from internet or local hard disk:

# From internet:

bf <- read.csv('http://sc.bnu.edu.cn/learning-r/big5.csv')

# From hard disk:

bf <- read.csv('./data/big5.csv')

# and inspect the data:

bf

#-------------------------------------------------------------------------------
# SECTION 2: PLOTTING WITH GGPLOT
#-------------------------------------------------------------------------------

# `ggplot` is a powerful tool to generate beautiful, color-blinded friendly plot
# for your research, let's load it firstly:

library(tidyverse) # Or use library(ggplot2) to load it indepently.

# 2.1 DOTPLOT
#~~~~~~~~~~~~~

# Now, Let's create a coordinate paper:

p0 <- ggplot(bf, aes(Neuroticism, Extraversion))
p0

# and draw some points on it:

p1 <- p + geom_point()
p1

# a regression line seems good, yes?

p2 <- p + stat_smooth()
p2

# anyone want to sperate different gender for different color?

p3 <- p0 + geom_point(aes(color = gender)) + stat_smooth()
p3

# or two regression lines?

p4 <- p0 +  geom_point() + stat_smooth(aes(fill = gender))
p4

# or both?
p5 <- ggplot(
  bf, aes(
    Neuroticism, Extraversion, 
    color = gender, fill = gender
  )) +
  geom_point() +
  stat_smooth()
p5

# maybe we want to change a theme to make the plot looks cleaner:

p6 <- p5 + theme_light()
p6

# 2.2 HOW DOES IT WORKS?
#~~~~~~~~~~~~~~~~~~~~~~~~

# While we are trying to plotting with ggplot, the first thing is creating a 
# coordinate paper with `ggplot()`:
# * The first parameter of this function is the data to be used while plotting, 
#   it should be a data frame; 
# * The second parameter is `mapping``, we specify which column of data is drawn
#   on the X axis, and which column of data is drawn on the Y axis with `aes()`.

# Aes is the abbr. of **aesthetic**, it will create a mapping option set for our
# plot, not only for mapping the data to which axis, but also mapping the group
# to different fill color, line color, or even dot size, opacity and more. To get
# detailed information, please read: *Ggplot2: Elegant Graphics for Data Analysis*

# Next, we stack a new layer above the coordinate paper, with operator `+`, it's
# quite intuitive. in this example, we stacked a dot plot with `geom_point()`,
# and a regression line with `stat_smooth`. To know more plotting layers, please
# check out: 
# https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf
# https://ggplot2.tidyverse.org/

# That's it, ggplot, a plotting package. In the following parts of this tutorial,
# we'll try to draw more different kinds of plots with it.

# 2.3 VIOLIN PLOT
#~~~~~~~~~~~~~~~~~

# Violin plot is a convinent way to show the distribution of our data:

p0 <- ggplot(bf, aes(drink, Agreeableness)) + geom_violin()
p0

# Of course, we can use `aes()` to mapping gender as color, as we used to do:

p1 <- ggplot(bf, aes(drink, Agreeableness)) + geom_violin(aes(fill = gender))
p1

# And we can beautify the plot by specifying opacity (alpha), and border color:

p2 <- ggplot(bf, aes(drink, Agreeableness)) + 
  geom_violin(alpha = 0.7, aes(fill = gender, color = gender))
p2

# Finally, a theme if you want:

p3 <- p2 + theme_light()
p3

# 2.4 HISTOGRAM
#~~~~~~~~~~~~~~~

# Another way to show the distribution of our data is histogram:

ggplot(bf, aes(Openness, color = home)) +
  geom_histogram(
    alpha = 0.7, 
    aes(fill = home)
  ) +
  theme_minimal()

# 2.5 MULTIPLOT
#~~~~~~~~~~~~~~~

# Sometimes, we may need to paint different parts of data into different plot
# ggplot has two function `facet_grid` and `facet_wrap`, helping us finish this 
# task, they have different using scenario but we'll only introduce `facet_grid`
# today.

# Firstly, let's create a dotplot, different color of the dots represents
# different age:

p0 <- ggplot(bf, aes(Openness, Agreeableness)) + geom_point(aes(color = age))

# Next, if we want to plot different gender to different plot, we can:

p0 + facet_grid(rows = vars(gender))

# Finally, to inspect whither there're some differences among drinking people 
# and no drinking people, we can:

p0 + facet_grid(rows = vars(gender), cols = vars(drink))
