#' This script is to test the function to verify that it works.

test_data <-readRDS(file = "Development/Testing_Data.rds")

test_data <- dplyr::as_tibble(test_data)

lookup <- readRDS(file = "Development/Species_Lookup_20240531.rds")

classify_species.custom(data = test_data,species_lookup = lookup,species_col = "Species")

i=1
# Ok let's make sure that this function actually works before we roll it into one thing.
test_data[["Species"]][i]
data=test_data
species_lookup=lookup
i=1



############################################### Function design non wrapped

species_lookup=lookup
species_col = "Species"
data=test_data
#make the new cols
data$family <- NA
data$order <- NA
data$scientific.name <- NA

for (i in 1:nrow(data)) {
  host <- data[[species_col]][i]
  host
  host <- gsub("_", " ", host) # Replace underscores
  host

  # Find matches in the lookup table
  matching_rows <- which(species_lookup$alt.common.name == host)
  y <- matching_rows
  # Add in the order, family and scientific name
  data$family[i] <- species_lookup$family[y]
  data$order[i] <- species_lookup$order[y]
  data$scientific.name[i] <- species_lookup$scientific.name[y]
 }

data |> print(n=50)

# Ok lets make this into a function:

classify_species <- function(data, species_col="Species"){
  species_lookup=usethis::use_data(file = "Development/Species_Lookup_20240531.rds")
  #make the new cols
  data$family <- NA
  data$order <- NA
  data$scientific.name <- NA

  for (i in 1:nrow(data)) {
    host <- data[[species_col]][i]
    host
    host <- gsub("_", " ", host) # Replace underscores
    host

    # Find matches in the lookup table
    matching_rows <- which(species_lookup$alt.common.name == host)
    y <- matching_rows
    # Add in the order, family and scientific name
    data$family[i] <- species_lookup$family[y]
    data$order[i] <- species_lookup$order[y]
    data$scientific.name[i] <- species_lookup$scientific.name[y]
  }
  return(data)
}

test_data |>
  dplyr::mutate(asda=Species) -> test_data

classify_species(data = test_data,species_col = "asda")
