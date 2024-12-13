## code to prepare `Species_Lookup_20241213.R` dataset goes here

data("Species_Lookup_20241204")

update_lookup(
  common.name = "say's phoebe",
  type = "songbird",
  scientific.name = "sayornis saya",
  english.name.ebird = "say's phoebe",
  order = "passeriformes",
  family="tyrannidae (tyrant flycatchers)",
  domestic = "wild",
  lookup_table = Species_Lookup_20241204
)-> new_lookup

update_lookup(common.name = "white-crowned sparrow",type = "songbird",scientific.name = "zonotrichia leucophrys",english.name.ebird = "white-crowned sparrow",order = 'passeriformes',family = 'passerellidae (new world sparrows)',domestic = 'wild',lookup_table = new_lookup)-> new_lookup

Species_Lookup_20241213 <- new_lookup

usethis::use_data(Species_Lookup_20241213, overwrite = TRUE)

#usethis::use_data(Species_Lookup_20241213.R, overwrite = TRUE)
