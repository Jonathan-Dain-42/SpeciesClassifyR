#' Classify Species in common names based on latin names.
#' @param data A data frame with species names you want to make common names
#'
#' @param species_col The names column you want to base your classification on
#'
#' @author Jonathan Dain \email{jonathan.dain001@umb.edu}
#'
#' @export
classify_species.scientific <- function(data, species_col="scientific.name"){
  utils::data("Species_Lookup_20240725")
  species_lookup <- Species_Lookup_20240725
  #make the new cols
  data$common.name <- NA

  for (i in 1:nrow(data)) {
    host <- data[[species_col]][i]
    host
    host <- gsub("_", " ", host) # Replace underscores
    host
    # Find matches in the lookup table
    matching_rows <- which(species_lookup$scientific.name == host)
    # Add in the unique scientific name
    name <- unique(species_lookup$enlish.name.ebird[matching_rows])
    data$common.name[i] <- name
  }
  return(tibble::as_tibble(data))
  }

