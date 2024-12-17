## code to prepare `Species_Lookup_20241217.R` dataset goes here

#' Ok so this datasheet needs to be uodated to include a few new things:
#' One the changes from my LPAI study......i.e. new bird spp.
#'
#' Two the updates to the USDA data.
#'
#' As a side note I need to make this function not fail but that is another
#' time and date to mess with that.
#'


library(devtools)
load_all()

?SpeciesClassifyR::update_lookup()

update_lookup(
  common.name = "string",
  type = "string",
  scientific.name = "string",
  english.name.ebird = "string",
  order = "string",
  family="string",
  domestic = "string",
  lookup_table = NULL
)


data("Species_Lookup_20241213")


update_lookup(
  common.name = "shorebird",
  type = "shorebird",
  scientific.name = "shorbird spp",
  english.name.ebird = "shorbid spp",
  order = "NA",
  family="NA",
  domestic = "wild",
  lookup_table = Species_Lookup_20241213
)->new_lookup

update_lookup(
  common.name = "red knot",
  type = "shorebird",
  scientific.name = "Calidris canutus",
  english.name.ebird = "red knot",
  order = "Charadriiformes",
  family="scolopacidae (sandpipers and allies)",
  domestic = "wild",
  lookup_table = new_lookup
)->new_lookup

update_lookup(
  common.name = "eurasian teal",
  type = "dabbling duck",
  scientific.name = "Anas crecca",
  english.name.ebird = "green-winged teal",
  order = "Anseriformes",
  family="anatidae (ducks, geese, and waterfowl)",
  domestic = "wild",
  lookup_table = new_lookup
)->new_lookup

update_lookup(
  common.name = "sandpiper",
  type = "shorebird",
  scientific.name = "sandpiper spp",
  english.name.ebird = "sandpiper spp",
  order = "NA",
  family="NA",
  domestic = "wild",
  lookup_table = new_lookup
)->new_lookup

update_lookup(
  common.name = "mallard-black duck hybrid",
  type = "dabbling duck",
  scientific.name = "hybrid spp",
  english.name.ebird = "hybrid spp",
  order = "NA",
  family="NA",
  domestic = "wild",
  lookup_table = new_lookup
)->new_lookup

update_lookup(
  common.name = "shoveler",
  type = "dabbling duck",
  scientific.name = "spatula clypeata",
  english.name.ebird = "northern shoveler",
  order = "anseriformes",
  family="anatidae (ducks, geese, and waterfowl)",
  domestic = "wild",
  lookup_table = new_lookup
)->new_lookup

update_lookup(
  common.name = "plover",
  type = "shorebird",
  scientific.name = "plover spp",
  english.name.ebird = "plover spp",
  order = "charadriiformes",
  family="charadriidae (plovers and lapwings)",
  domestic = "wild",
  lookup_table = new_lookup
)->new_lookup

update_lookup(
  common.name = "coot",
  type = "wading birds",
  scientific.name = "fulica americana",
  english.name.ebird = "american coot",
  order = "gruiformes",
  family="rallidae (rails, gallinules, and coots)",
  domestic = "wild",
  lookup_table = new_lookup
)->new_lookup

update_lookup(
  common.name = "teal",
  type = "dabbling duck",
  scientific.name = "teal spp",
  english.name.ebird = "teal spp",
  order = "Anseriformes",
  family="anatidae (ducks, geese, and waterfowl)",
  domestic = "wild",
  lookup_table = new_lookup
)->new_lookup

update_lookup(
  common.name = "steller's eider",
  type = "seaduck",
  scientific.name = "Polysticta stelleri",
  english.name.ebird = "steller's eider",
  order = "Anseriformes",
  family="anatidae (ducks, geese, and waterfowl)",
  domestic = "wild",
  lookup_table = new_lookup
)->new_lookup

update_lookup(
  common.name = "white-winged dove",
  type = "other",
  scientific.name = "Zenaida asiatica",
  english.name.ebird = "white-winged dove",
  order = "columbiformes",
  family="columbidae (pigeons and doves)",
  domestic = "wild",
  lookup_table = new_lookup
)->new_lookup

update_lookup(
  common.name = "kookaburra (unidentified)",
  type = "other",
  scientific.name = "kookaburra spp",
  english.name.ebird = "kookaburra spp",
  order = "NA",
  family="NA",
  domestic = "domestic",
  lookup_table = new_lookup
)->new_lookup

new_lookup |>
  dplyr::mutate_all(tolower)->new_lookup

new_lookup ->Species_Lookup_20241217

usethis::use_data(Species_Lookup_20241217, overwrite = TRUE)

