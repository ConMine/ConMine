library(shiny)
library(tidyverse)

#Loading data
other_data <- read.csv("../Data/parrot_csv/parrot_shiny.csv")




#get parrot names
names <- gsub("_"," ",sort(unique(other_data$Species)))

#plotting imputation
