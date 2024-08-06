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

document()

#update the classify functions to utilize this new lookup file.
use_r(name = "classify_species.common.R")
use_r(name="classify_species.scientific.R")

#update the update_lookup helper to default to new lookup sheet
use_r(name="update_lookup_helper.R")

#update the test datasets to be consistent with the new species lookup
#' doing manually with each.
#'
#' test_dataset.R (with new species lookup and lowercase)
#' update_clean_dataset.R (with the new species lookup)
#' clean_test_dataset.R (with the new species lookup)
#' scientific.name_data_clean.R (with the new species lookup) - Actually not needed since it internally used the functions.
#' update_test_dataset.R (with the new species lookup)

# run the test()
unload()
load_all()
document()
test()
check()

#' Alright all the functions are now updated with the new species
#' lookup file which has some african species as well as the
#' entire lookup is lowercase, which generally makes things
#' easier. Finally let's update the version to what we want.


