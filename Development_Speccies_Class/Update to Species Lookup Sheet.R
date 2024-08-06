#' =======================================
#' Update to the Species Lookup Sheet
#'
#' Nichola asked me to make a list of the following top 30 species
#' down to family but I figured I would take it one step further
#' and just add them to the SpeciesClassifyR package just so I can
#' have them for future use.
#'
#' If she needs them seperately I can just pull them out as a .csv
#' file that is needed.
#'
#'  Date: 20240806
#' ======================================


## The list that she needs the species from:
# https://ebird.org/hotspot/L1036313/bird-list?hs_sortBy=count

## Load some packages

library(devtools)
load_all()

data("Species_Lookup_20240806")
#' I place all of the above code into this:
use_data_raw(name = "Species_Lookup_20240806.R")

test()
load_all()
check()

#update the version number
usethis::use_version(which = "minor",push = FALSE)
