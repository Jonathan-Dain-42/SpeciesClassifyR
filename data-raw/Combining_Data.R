## code to prepare `Combining_Data` dataset goes here

## This script will create a combination system data for my package.

load(file = "data/clean_test_data.rda")
load(file = "data/Species_Lookup_20240725.rda")
load(file = "data/test_dat.rda")
load(file = "data/update_test_dataset.rda")
load(file = "data/update_clean_dataset.rda")
load(file = "data/Species_Lookup_20240806.rda")
load(file = "data/Species_Lookup_20241204.rda")
load(file = "data/Species_Lookup_20241213.rda")
load(file="data/Species_Lookup_20241217.rda")
load(file = 'data/type_clean_dataset.rda')


usethis::use_data(clean_test_data,
                  test_dat,
                  Species_Lookup_20240725,
                  update_test_dataset,
                  update_clean_dataset,
                  Species_Lookup_20240806,
                  Species_Lookup_20241204,
                  Species_Lookup_20241213,
                  Species_Lookup_20241217,
                  type_clean_dataset,
                  overwrite = TRUE,
                  internal = T)
