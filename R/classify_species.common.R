#' Classify Species in latin names based on common names.
#' @param data A data frame with species names you want to make latin names
#'
#' @param species_col The names column you want to base your classification on
#'
#' @author Jonathan Dain \email{jonathan.dain001@umb.edu}
#'
#' @export
classify_species.common <- function(data, species_col="Species"){
  utils::data('Species_Lookup_20241217')
  species_lookup <- Species_Lookup_20241217
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
  return(tibble::as_tibble(data))
}

