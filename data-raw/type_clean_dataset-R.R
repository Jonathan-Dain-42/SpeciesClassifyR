## code to prepare `type_clean_dataset.R` dataset goes here

library(devtools)
load_all()

data("test_dat")

classify_species.common(data = test_dat,species_col = "Species")->obj

obj

classify_species.type(data = obj,species_col = "scientific.name")->clean_dat

type_clean_dataset <- clean_dat

usethis::use_data(type_clean_dataset, overwrite = TRUE)
