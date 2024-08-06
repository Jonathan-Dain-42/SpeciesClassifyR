#' ============================================
#' I made an update to the "update lookup" function which will
#' allow the user to define a custom lookup table if they would
#' like to update one that is not the default.
#'
#' This will allow people greater freedom in which taxa they add
#' as well as allow them to add more than one at a time and then
#' append each row to the newly created dataframe
#'
#' It will also allow me the developer to update it as needed.

library(devtools)

document()

test()

check()

use_test(name = "update_lookup_helper.R")

document()

test()

check()

usethis::use_version(which = "minor",push = FALSE)
usethis::use_news_md()

document()
test()
check()
build_readme()
document()
