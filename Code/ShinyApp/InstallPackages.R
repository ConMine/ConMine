#!/usr/bin/env Rscript

##Installing packages
if (!require("shiny")) install.packages("shiny")
if (!require("dplyr")) install.packages("dplyr")
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("rworldmap")) install.packages("rworldmap")
if (!require("maps")) install.packages("maps")
if (!require("countrycode")) install.packages("countrycode")
if (!require("WikipediR")) install.packages("WikipediR")
if (!require("rvest")) install.packages("rvest")