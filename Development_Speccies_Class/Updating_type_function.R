#' ++++++++++++++++++++++++++++++++++++
#'
#' @author Jonathan Dain
#'
#' Date: 20241204
#'
#' Updating the package to add in the type classify function.
#' +++++++++++++++++++++++++++++++++++


library(devtools)
load_all()

use_r(name = "classify_species.type.R")

document()

data("test_dat")

classify_species.common(data = test_dat,species_col = "Species")->obj

classify_species.type(data = obj,species_col = "scientific.name")

# use_data_raw(name = "type_test_dataset.R")
use_data_raw(name="type_clean_dataset.R")

use_test("classify_species.type.R")

document()
test()
check()

usethis::use_version(which = "minor",push = FALSE)

#data("Species_Lookup_20241204")

#' Fixed a minor typo in my code about 'wading bords' lol.
usethis::use_version(which = "patch",push = FALSE)

