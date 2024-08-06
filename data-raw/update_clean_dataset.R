## code to prepare `update_clean_dataset` dataset goes here

# data <- readRDS(file = "Development_Speccies_Class/Species_Lookup_20240725.rds")

load(file = "data/Species_Lookup_20240806.rda")
data <- Species_Lookup_20240806

# data <- data[1:10,]

data <- data |>
  rbind(c("mallard",'dabbling duck','anas platyrhynchos','mallard','anseriformes','anatidae (ducks, geese, and waterfowl)','wild'))

update_clean_dataset <- data

usethis::use_data(update_clean_dataset, overwrite = TRUE)
