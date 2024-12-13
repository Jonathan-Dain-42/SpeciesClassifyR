#' =======================================
#' Update to the Species Lookup Sheet
#'
#' I recently updated a script using the USDA data and discovered a need for a update
#' to my species lookup functions. Below is the update to that.
#'
#'  Date: 20241213
#' ======================================

library(devtools)
load_all()

use_data_raw(name = "Species_Lookup_20241213.R")

unload()
test()
load_all()
check()

#update the classify functions to utilize this new lookup file.
use_r(name = "classify_species.common.R")
use_r(name="classify_species.scientific.R")
use_r(name = 'classify_species.type.R')

#update the update_lookup helper to default to new lookup sheet
use_r(name="update_lookup_helper.R")

unload()
test()
load_all()
check()

usethis::use_version(which = "minor",push = FALSE)
