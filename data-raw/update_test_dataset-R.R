## code to prepare `update_test_dataset.R` dataset goes here

test_data <- readRDS(file = "Development_Speccies_Class/Species_Lookup_20240725.rds")

update_test_dataset <- test_data #[1:10,]

usethis::use_data(update_test_dataset, overwrite = TRUE)

