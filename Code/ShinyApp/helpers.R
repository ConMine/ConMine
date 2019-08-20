library(shiny)
library(tidyverse)

#Loading data
<<<<<<< HEAD
other_data <- read.csv("../Data/parrot_csv/parrot_shiny.csv",stringsAsFactors = F)
marked_text <- read.csv("../Data/parrot_csv/marked_text.csv",stringsAsFactors = F)


#get parrot names
names <- gsub("_"," ",sort(unique(other_data$Species)))

#get Country name
countries <- unique(marked_text$Country)

#Welcome Text

=======
other_data <- read.csv("../Data/parrot_csv/parrot_shiny.csv")




#get parrot names
names <- gsub("_"," ",sort(unique(other_data$Species)))

#plotting imputation
>>>>>>> b8a18a08c5bde0216505fdc767ff77cbe66fed7b
