## code to prepare `scientific.name_data_clean.R` dataset goes here

data("test_dat")

#first go from common name to scientific name
classify_species.common(data = test_dat,species_col = "Species") |>
  #Then go back to common name from scientific name
  classify_species.scientific(species_col = "scientific.name")->scientific.name_data_clean



usethis::use_data(scientific.name_data_clean, overwrite = TRUE)
