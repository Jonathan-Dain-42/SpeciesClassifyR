#' =======================================
#' Update to the Species Lookup Sheet
#'
#' I need to add a few more species from both the USDA data side for the app,
#' as well for my LPAI study.
#'
#' I will also lay out the protocol for updating this here.
#'
#'  Date: 20241213
#' ======================================

# ONE: Load Devtools and your package
library(devtools)
load_all()

# TWO: Generate your new data sheet

use_data_raw(name = "Species_Lookup_20241217.R")

# THREE: Update your functions to default to the new lookup file

use_r(name = "classify_species.common.R")
use_r(name="classify_species.scientific.R")
use_r(name = 'classify_species.type.R')
use_r(name="update_lookup_helper.R")

# FOUR: Run the combine date script in the raw_data folder to generat system files

# FIVE: Unload and document everything.
unload()
test()
load_all()
check()
document()

# SIX: Push to Github

# SEVEN: Update the patch version as well as NEWS. Then push to GitHub.
usethis::use_version(which = "minor",push = FALSE)
