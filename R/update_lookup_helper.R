#' Update Lookup Helper
#'
#' @param common.name an alternative common name, usually a misspelling of a traditional common name.
#' @param type the management type of the species i.e. (other,songbird, seabird, dabbling duck, raptor/owl/falcon, goose/swan, shorebird, gull, seaduck, chicken, domestic poultry, mammal, NA)
#' @param scientific.name the scientific name for this species. It is recommended to use https://birdsoftheworld.org for the most up to date taxonomy.
#' @param english.name.ebird the english name from https://birdsoftheworld.org for this species
#' @param order the https://birdsoftheworld.org taxonomic order for this species
#' @param family the https://birdsoftheworld.org taxonomic family for this species.
#' @param domestic whether this is a domestic or wild species.
#' @param lookup_table a user defined lookup table to allow for further editing. The default is set to NULL and utilizes the lookup table provided in the package.
#'
#' @return Returns the updated lookup table with the new row added. It is highly recommended that the user save this as a seperate lookup file to be used with `classify_species.custom()` in the future.
#'
#' @export
#'
#' @author Jonathan Dain,
#'
update_lookup <- function(common.name="string",type="string",scientific.name="string",english.name.ebird="string",order="string",family,domestic="string",lookup_table = NULL){
  if (is.null(lookup_table)) {
    utils::data("Species_Lookup_20240725")
    lookup <- Species_Lookup_20240725
  } else {
    lookup <- lookup_table
  }
  new_row <- dplyr::tibble(alt.common.name=common.name,type=type,scientific.name=scientific.name,enlish.name.ebird=english.name.ebird,order=order,family=family,domestic=domestic) #make the new row
  lookup <- dplyr::bind_rows(lookup,new_row) #bind the new row
  return(tibble::as_tibble(lookup)) #return the updated file.
}
