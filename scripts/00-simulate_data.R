# Purpose: Simulate the data
# Author: Boxuan Yi
# Email: boxuan.yi@mail.utoronto.ca
# Date: 28 November 2024
# Prerequisites: None

library(tibble)
library(dplyr)
library(readr)

set.seed(7)

simulated_data <- tibble(
  id = 1:500,
  BIRTH_YR = sample(2005:2023, 500, replace = TRUE), 
  A1_MENTHEALTH = sample(1:5, 500, replace = TRUE), 
  A2_MENTHEALTH = sample(1:5, 500, replace = TRUE), 
  screentime = sample(1:5, 500, replace = TRUE), 
  bullied = sample(1:5, 500, replace = TRUE), 
  friends = sample(1:3, 500, replace = TRUE),
  hopeful = sample(1:4, 500, replace = TRUE),
  violence = sample(1:2, 500, replace = TRUE),
  live_with_mental = sample(1:2, 500, replace = TRUE), 
  depression = sample(1:2, 500, replace = TRUE)
) |>
  mutate(
    age = 2024 - BIRTH_YR,
    parent_mental_health = rowMeans(cbind(A1_MENTHEALTH, A2_MENTHEALTH), na.rm = TRUE),
    hopeful = case_when(
      parent_mental_health >= 4 ~ sample(1:4, n(), replace = TRUE, prob = c(0.1, 0.2, 0.3, 0.4)), 
      parent_mental_health <= 2 ~ sample(1:4, n(), replace = TRUE, prob = c(0.4, 0.3, 0.2, 0.1)), 
      TRUE ~ hopeful
    ),
    friends = case_when(
      bullied >= 4 ~ sample(1:3, n(), replace = TRUE, prob = c(0.3, 0.3, 0.4)), 
      bullied <= 2 ~ sample(1:3, n(), replace = TRUE, prob = c(0.7, 0.2, 0.1)), 
      TRUE ~ friends
    ),
    screentime = case_when(
      age <= 6 ~ sample(1:5, n(), replace = TRUE, prob = c(0.3, 0.3, 0.2, 0.1, 0.1)),
      age >= 13 ~ sample(1:5, n(), replace = TRUE, prob = c(0.1, 0.1, 0.1, 0.3, 0.4)), 
      TRUE ~ screentime 
    )
  ) |>
  mutate(
    depression = recode(depression, `1` = "Yes", `2` = "No"),
    screentime = recode(screentime, `1` = "Less than 1 hour", `2` = "1 hour", 
                        `3` = "2 hours", `4` = "3 hours", `5` = "4 or more hours"),
    bullied = recode(bullied, `1` = "Never", `2` = "1-2 times in the past year", 
                     `3` = "1-2 times per month", `4` = "1-2 times per week", `5` = "Almost every day"),
    friends = recode(friends, `1` = "No difficulty", `2` = "A little difficulty", 
                     `3` = "A lot of difficulty"),
    hopeful = recode(hopeful, `1` = "All of the time", `2` = "Most of the time", 
                     `3` = "Some of the time", `4` = "None of the time"),
    violence = recode(violence, `1` = "Yes", `2` = "No"),
    live_with_mental = recode(live_with_mental, `1` = "Yes", `2` = "No")
  )


write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
