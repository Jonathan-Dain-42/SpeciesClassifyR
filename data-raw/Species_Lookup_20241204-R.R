## code to prepare `Species_Lookup_20241204.R` dataset goes here

#' =======================================
#' Update to the Species Lookup Sheet
#'
#' I recently updated a script using the USDA data and discovered a need for a update
#' to my species lookup functions. Below is the update to that.
#'
#'  Date: 20241204
#' ======================================

library(devtools)

data("Species_Lookup_20240806")

# update_lookup(
#   common.name = "string",
#   type = "string",
#   scientific.name = "string",
#   english.name.ebird = "string",
#   order = "string",
#   family,
#   domestic = "string",
#   lookup_table = NULL
# )
#
# update_lookup(
#   common.name = "string",
#   type = "string",
#   scientific.name = "string",
#   english.name.ebird = "string",
#   order = "string",
#   family="string",
#   domestic = "string",
#   lookup_table = new_lookup
# )->new_lookup

###### Updating the Tibble
update_lookup(
  common.name = "lark sparrow",
  type = "songbird",
  scientific.name = "Chondestes grammacus",
  english.name.ebird = "lark sparrow",
  order = "passeriformes",
  family="passerellidae (new world sparrows)",
  domestic = "wild",
  lookup_table = NULL
)->new_lookup


update_lookup(
  common.name = "lark bunting",
  type = "songbird",
  scientific.name = "Calamospiza melanocorys",
  english.name.ebird = "lark bunting",
  order = "passeriformes",
  family="passerellidae (new world sparrows)",
  domestic = "wild",
  lookup_table = new_lookup
)->new_lookup

update_lookup(
  common.name = "western kingbird",
  type = "songbird",
  scientific.name = "Tyrannus verticalis",
  english.name.ebird = "western kingbird",
  order = "Passeriformes",
  family="tyrannidae (tyrant flycatchers)",
  domestic = "wild",
  lookup_table = new_lookup
)->new_lookup

update_lookup(
  common.name = "long-tailed duck",
  type = "seaduck",
  scientific.name = "Clangula hyemalis",
  english.name.ebird = "long-tailed duck",
  order = "anseriformes",
  family="anatidae",
  domestic = "wild",
  lookup_table = new_lookup
)->new_lookup

update_lookup(
  common.name = "brewer's blackbird",
  type = "songbird",
  scientific.name = "Euphagus cyanocephalus",
  english.name.ebird = "brewer's blackbird",
  order = "Passeriformes",
  family="icteridae (troupials and allies)",
  domestic = "wild",
  lookup_table = new_lookup
)->new_lookup

update_lookup(
  common.name = "wild hybrid duck (anatidae)",
  type = "dabbling duck",
  scientific.name = "duck spp",
  english.name.ebird = "duck spp",
  order = "anserifromes",
  family="anatidae",
  domestic = "wild",
  lookup_table = new_lookup
)->new_lookup

update_lookup(
  common.name = "song sparrow",
  type = "songbird",
  scientific.name = "Melospiza melodia",
  english.name.ebird = "song sparrow",
  order = "passeriformes",
  family="passerellidae (new world sparrows)",
  domestic = "wild",
  lookup_table = new_lookup
)->new_lookup

update_lookup(
  common.name = "savannah sparrow",
  type = "songbird",
  scientific.name = "Passerculus sandwichensis",
  english.name.ebird = "savannah sparrow",
  order = "passeriformes",
  family="passerellidae (new world sparrows)",
  domestic = "wild",
  lookup_table = new_lookup
)->new_lookup

# make it all lowercase
new_lookup |>
  dplyr::mutate_all(.funs=tolower)->new_lookup

# new_lookup |>
#   dplyr::filter(type=="other") |> View()

# add in the wading birds and fix a few typos
new_lookup$type[new_lookup$family%in%c("gruidae (cranes)",'rallidae (rails, gallinules, and coots)','ciconiidae (storks)','ardeidae (herons, egrets, and bitterns)','phoenicopteridae (flamingos)','threskiornithidae (ibises and spoonbills)')] <- "wading bords"

new_lookup$family[new_lookup$family=="lardeidae (herons, egrets, and bitterns)"] <- 'ardeidae (herons, egrets, and bitterns)'

new_lookup$type[new_lookup$family=="ardeidae (herons, egrets, and bitterns)"] <-'wading birds'

#rename to Species_Lookup_20240806
Species_Lookup_20241204 <- new_lookup

usethis::use_data(Species_Lookup_20241204, overwrite = TRUE)
