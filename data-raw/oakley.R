## code to prepare `oakley` dataset goes here

# data from: Oakley, C., Ågren, J. & Schemske, D. Heterosis and outbreeding depression in crosses between natural populations of Arabidopsis thaliana. Heredity 115, 73–82 (2015). https://doi.org/10.1038/hdy.2015.18
library(tidyverse)

# read in raw data
d <- read.csv("data-raw/oakley.csv")

d %>%
  #mutate(full_size = ifelse(SizeCat==0 | is.na(SizeCat), 0, 1)) %>%
  mutate(full_size = case_when(is.na(SizeCat) | SizeCat==0 ~ 0,
                               T ~ 1)) %>%
  filter(PopSet=="BS") %>%
  mutate(cross = case_when(grepl("F2", JointScaleCrossType) ~ "f2",
                           grepl("F1", JointScaleCrossType) ~ "f1",
                           JointScaleCrossType=="BC1P1" ~ "bc1",
                           JointScaleCrossType=="BC1P2" ~ "bc2",
                           JointScaleCrossType=="P1" ~ "p1",
                           JointScaleCrossType=="P2" ~ "p2"),
         anc_prop = case_when(grepl("F2", JointScaleCrossType) ~ .5,
                           grepl("F1", JointScaleCrossType) ~ .5,
                           JointScaleCrossType=="BC1P1" ~ .25,
                           JointScaleCrossType=="BC1P2" ~ .75,
                           JointScaleCrossType=="P1" ~ 0,
                           JointScaleCrossType=="P2" ~ 1),
         anc_het = case_when(grepl("F2", JointScaleCrossType) ~ .5,
                           grepl("F1", JointScaleCrossType) ~ 1,
                           JointScaleCrossType=="BC1P1" ~ .5,
                           JointScaleCrossType=="BC1P2" ~ .5,
                           JointScaleCrossType=="P1" ~ 0,
                           JointScaleCrossType=="P2" ~ 0)) %>%
  select(full_size, anc_prop, anc_het) -> oakley


usethis::use_data(oakley, overwrite = TRUE)

