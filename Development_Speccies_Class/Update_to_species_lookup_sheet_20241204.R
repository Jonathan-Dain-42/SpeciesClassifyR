#' =======================================
#' Update to the Species Lookup Sheet
#'
#' I recently updated a script using the USDA data and discovered a need for a update
#' to my species lookup functions. Below is the update to that.
#'
#'  Date: 20241204
#' ======================================

library(devtools)
load_all()

use_data_raw(name = "Species_Lookup_20241204.R")

unload()
test()
load_all()
check()

#update the classify functions to utilize this new lookup file.
use_r(name = "classify_species.common.R")
use_r(name="classify_species.scientific.R")

#update the update_lookup helper to default to new lookup sheet
use_r(name="update_lookup_helper.R")

# #update the test datasets to be consistent with the new species lookupdoing manually with each.
#
# test_dataset.R (with new species lookup and lowercase)
# update_clean_dataset.R (with the new species lookup)
# clean_test_dataset.R (with the new species lookup)
# scientific.name_data_clean.R (with the new species lookup) - Actually not needed since it internally used the functions.
# update_test_dataset.R (with the new species lookup)

#' The above updating was not done today 20241204

usethis::use_version(which = "minor",push = FALSE)
document()


