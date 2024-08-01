## code to prepare `Species_Lookup_20240725` dataset goes here

Species_Lookup_20240725 <- readRDS(system.file("Development_Speccies_Class","Species_Lookup_20240725.rds",package = "SpeciesClassifier"))

usethis::use_data(Species_Lookup_20240725, overwrite = TRUE)
