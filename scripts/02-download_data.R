#### Preamble ####
# Purpose: Download and Read in data
# Author: Boxuan Yi
# Email: boxuan.yi@mail.utoronto.ca
# Date: 26 November 2024
# Prerequisites: None

# The raw datasets are downloaded manually from
# https://www.census.gov/programs-surveys/nsch/data/datasets.html

library(here)
library(haven)

# Read in the SAS dataset
data_raw <- read_sas(here("data", "01-raw_data", 
                              "nsch_2023e_screener.sas7bdat"))

# Save the dataset as a CSV file
write_csv(
  x = data_raw,
  file = here("data", "01-raw_data", "data_raw.csv"))
