library(shiny)
library(tidyverse)

#Loading data
other_data <- read.csv("../Data/parrot_csv/parrot_shiny.csv",stringsAsFactors = F)

marked_1 <- read.csv("../Data/parrot_csv/marked_text1.csv",stringsAsFactors = F)
marked_2 <- read.csv("../Data/parrot_csv/marked_text2.csv",stringsAsFactors = F)
marked_3 <- read.csv("../Data/parrot_csv/marked_text3.csv",stringsAsFactors = F)
marked_text <- rbind(marked_1,marked_2,marked_3)

#get parrot names
names <- gsub("_"," ",sort(unique(other_data$Species)))

#get Country name
countries <- unique(marked_text$Country)
