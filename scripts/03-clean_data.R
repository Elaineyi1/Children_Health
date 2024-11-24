#### Preamble ####
# Purpose: Clean the dataset
# Author: Boxuan Yi
# Email: boxuan.yi@mail.utoronto.ca
# Date: 23 November 2024
# Prerequisites: Be familiar with the dataset and its methodology.

library(here)
library(haven)
library(tidyr)
library(janitor)
library(arrow)
library(dplyr) 

data_raw <- read_sas(here("data", "01-raw_data", 
                          "nsch_2023e_screener.sas7bdat"))

data_cleaned <- data_raw |>
  clean_names() |>
  select(
    c_k2q22, c_k2q16, c_race_r, c_age_years, c_english, 
    tenure, totkids_r, c_sex, cbsafp_yn, hhids, stratum) |> 
  drop_na() |>
  mutate(
    age_group = case_when(
      c_age_years <= 6 ~ "6 or younger",
      c_age_years >= 7 & c_age_years <= 12 ~ "7-12",
      c_age_years >= 13 & c_age_years <= 17 ~ "13-17")) |> 
  rename(
    child_emotion_develop = c_k2q22,
    child_limited_ability = c_k2q16,
    race = c_race_r,
    age = c_age_years,
    english = c_english,
    kids_number = totkids_r,
    sex = c_sex,
    cbsa = cbsafp_yn
  )

data_cleaned <- data_cleaned |> mutate(
  sex = recode(sex, `1` = "Male", `2` = "Female"),
  english = recode(english, `1` = "Very well", `2` = "Well", `3` = "Not well", 
                   `4` = "Not at all"),
  race = recode(race, `1` = "White", `2` = "Black", `3` = "American Indian or Alaska Native", 
                `4` = "Asian", `5` = "Native Hawaiian or Pacific Islander", 
                `7` = "Mixed race"),
  child_emotion_develop = recode(child_emotion_develop, `1` = "Yes", `2` = "No"),
  child_limited_ability = recode(child_limited_ability, `1` = "Yes", `2` = "No"),
  tenure = recode(tenure, `1` = "Owned with mortgage or loan", 
                  `2` = "Owned free and clear", `3` = "Rented", 
                  `4` = "Occupied without payment of rent"),
  kids_number = recode(kids_number, `1` = "1 child", `2` = "2 children", 
                       `3` = "3 children", `4` = "4 or more children"),
  cbsa = recode(cbsa, `1` = "Located within CBSA", `2` = "Located outside CBSA")
)

data_cleaned$child_emotion_develop <- as.factor(data_cleaned$child_emotion_develop)

# Testing/Training splits
set.seed(7)
n <- nrow(data_cleaned)
train_indices <- sample(1:n, size = 0.8 * n)

train_data <- data_cleaned[train_indices, ]
test_data <- data_cleaned[-train_indices, ]


# Save as a parquet file
write_parquet(
  x = data_cleaned,
  sink = here("data", "02-analysis_data", "children_health.parquet")
)

write_parquet(
  x = train_data,
  sink = here("data", "02-analysis_data", "train_data.parquet")
)

write_parquet(
  x = test_data,
  sink = here("data", "02-analysis_data", "test_data.parquet")
)
