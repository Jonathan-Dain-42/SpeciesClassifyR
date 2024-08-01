library(devtools)
library(tidyverse)

use_r("classify_species.common.R")

load_all()
check()
use_mit_license()
document()
?classify_species.common
?update_lookup

test()

## Lets just see if it works.
test_dat <- readRDS(file = "Development_Speccies_Class/Testing_Data.rds")
classify_species.common(data = test_dat,species_col = "Species")

## Lets make sure we can automate testing
use_testthat() #initial setup

use_test("classify_species.common.R")



ref_data <- readRDS(file = "Development_Speccies_Class/Species_Lookup_20240531.rds")
test_dat$family <- NA
test_dat$order <- NA
test_dat$scientific.name <- NA

for(i in 1:nrow(test_dat)){ #loops through the rows
  host <- test_dat$Species[i] #finds the host name
  host
  if (host %in% Species_Lookup$alt.common.name){ #checks to see if it's in the data
    y <- which(Species_Lookup$alt.common.name==host) #gets an index
    y
    test_dat$scientific.name[i] <- Species_Lookup$scientific.name[y] #replaces it with a species
    test_dat$family[i] <- Species_Lookup$family[y]
    test_dat$order[i] <- Species_Lookup$order[y]
  }
}

saveRDS(object = test_dat,file = "Development_Speccies_Class/clean_test_data.rds")

install()

check()

load(system.file("data", "test_dat.rda", package="SpeciesClassifier"))

test_active_file()

use_data_raw(name = "Species_Lookup_20240725")
use_data_raw(name = "Combining_Data")

system.file('R','sysdata.rda', package = "SpeciesClassifier") |> list.files()

use_r(name = "update_lookup_helper.R")


use_data_raw(name = "update_test_dataset.R")
use_data_raw(name="update_clean_dataset")

use_test("update_lookup_helper.R")


test()

check()

use_package("dplyr")


use_r(name = "classify_species.custom.R")
document()
load_all()
?classify_species.custom
#use_package("tibble")

?classify_species.custom()

# make a git repository
use_git()

## add the read me
use_readme_rmd()

#adding in the BEAST helper function.
use_r("days_to_run.R")
# remove.packages(pkgs = "SpeciesClassifier")
document()
?days_to_run

use_test("days_to_run.R")
test()
load_all()
check()

#testing
