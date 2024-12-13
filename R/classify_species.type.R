#' Classify Species in functional groups (types) based on scientific names:
#' @param data A data frame with species names you want to add the type too
#'
#' @param species_col The names column you want to base your classification on
#'
#' @author Jonathan Dain \email{jonathan.dain001@umb.edu}
#'
#' @export
classify_species.type <- function(data, species_col="Species"){
  utils::data('Species_Lookup_20241213')
  species_lookup <- Species_Lookup_20241213
  #make the new cols
  data$spp_type <- NA

  for (i in 1:nrow(data)) {
    host <- data[[species_col]][i]
    host
    host <- gsub("_", " ", host) # Replace underscores
    host

    # Find matches in the lookup table
    matching_rows <- which(species_lookup$scientific.name == host)
    # Add in the unique scientific name
    name <- unique(species_lookup$type[matching_rows])
    data$spp_type[i] <- name
  }
  return(tibble::as_tibble(data))
  }

