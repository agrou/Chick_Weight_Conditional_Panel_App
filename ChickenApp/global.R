library(shinydashboard)
library(tidyverse)
library(DT)
library(stringr)

#load("Chick_base.RData", envir = .GlobalEnv)

# For this example we use ChickWeight data available in the package 'datasets'
data(ChickWeight)

## The following code was adapted from www.github.com/saghirb/Chick_Weight_Basic_App-master

# Data cleaning

CW <- ChickWeight %>%
        # convert chicken id from factor to numeric values
        mutate(Chick = as.numeric(as.character(Chick)),
               Diet = str_c("Diet", as.character(Diet), sep = " ")) %>%
        select(Chick, Diet, Time, Weight = weight) %>%
        arrange(Chick, Diet, Time)

rWgt <- range(CW$Weight)        

CW_sum_stats <- CW %>%
        group_by(Diet, Time) %>%
        summarise(N = n(),
                  Mean = mean(Weight),
                  SD = sd(Weight),
                  Min = min(Weight),
                  Median = median(Weight),
                  Max = max(Weight)) %>%
        arrange(Time)

CW_stats_new <- CW_sum_stats %>%
        mutate(N = as.character(N), 
               `Mean(SD)` = sprintf("%6.1f(%6.2f)", Mean, SD),
               `Mean(SD)` = str_replace_all(`Mean(SD)`, "[\\s]", ""),
               Median = sprintf("%6.1f", Median),
               `Min-Max` = sprintf("%6.1f-%6.1f", Min, Max),
               `Min-Max` = str_replace_all(`Min-Max`, "[\\s]", "")) %>%
        arrange(Time)
        
        

        