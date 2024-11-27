# Purpose: Simulate the data
# Author: Boxuan Yi
# Email: boxuan.yi@mail.utoronto.ca
# Date: 23 November 2024
# Prerequisites: None

library(tibble)
library(dplyr)
library(readr)

set.seed(7)

simulated_data <- tibble(
  id = 1:500,
  child_emotion_develop = sample(c("Yes", "No"), 500, replace = TRUE, prob = c(0.3, 0.7)),
  child_limited_ability = sample(c("Yes", "No"), 500, replace = TRUE, prob = c(0.2, 0.8)),
  race = sample(c("White", "Black", "American Indian or Alaska Native", 
                  "Asian", "Native Hawaiian or Pacific Islander", "Mixed race"), 
                500, replace = TRUE, prob = c(0.5, 0.15, 0.05, 0.1, 0.05, 0.15)),
  age = sample(1:17, 500, replace = TRUE),
  tenure = sample(c("Owned with mortgage or loan", "Owned free and clear", 
                    "Rented", "Occupied without payment of rent"), 
                  500, replace = TRUE, prob = c(0.5, 0.2, 0.25, 0.05)),
  kids_number = sample(c("1 child", "2 children", "3 children", "4 or more children"), 
                       500, replace = TRUE, prob = c(0.25, 0.35, 0.25, 0.15)),
  sex = sample(c("Male", "Female"), 500, replace = TRUE, prob = c(0.5, 0.5)),
  cbsa = sample(c("Located within CBSA", "Located outside CBSA"), 
                500, replace = TRUE, prob = c(0.8, 0.2)),
  age_group = case_when(
    age <= 6 ~ "6 or younger",
    age >= 7 & age <= 12 ~ "7-12",
    age >= 13 & age <= 17 ~ "13-17"
  )
) |> mutate(
  cbsa = case_when(
    tenure == "Occupied without payment of rent" ~ sample(c("Located within CBSA", "Located outside CBSA"), n(), replace = TRUE, 
                                                          prob = c(0.6, 0.4)),
    TRUE ~ cbsa 
  ),
  english = case_when(
    age <= 4 ~ NA_character_,
    age <= 6 ~ sample(c("Very well", "Well", "Not well", "Not at all"), n(), replace = TRUE, prob = c(0.4, 0.4, 0.15, 0.05)),
    age <= 12 ~ sample(c("Very well", "Well", "Not well", "Not at all"), n(), replace = TRUE, prob = c(0.6, 0.25, 0.1, 0.05)),
    age <= 17 ~ sample(c("Very well", "Well", "Not well", "Not at all"), n(), replace = TRUE, prob = c(0.7, 0.2, 0.05, 0.05))
  )
)

write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
