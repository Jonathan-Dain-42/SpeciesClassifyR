#' Title
#'
#' @param data A data grame with species names you want to convert to latin names.
#' @param species_col The common names column you want to base your classification on.
#' @param lookup_table A custom lookup table that you either created by hand or obtained from `update_lookup()`.
#'
#' @return Returns a dataframe with the classifications.
#' @export
#'
#'
classify_species.custom <- function(data,species_col="Species",lookup_table){
  species_lookup <- lookup_table
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
  return(tibble::as.tibble(data))
}
