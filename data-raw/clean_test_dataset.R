#load in the test dataset
test_dat <- readRDS(file = "Development_Speccies_Class/Testing_Data.rds")

# added on 20240806
test_dat |>
  dplyr::mutate_all(.funs=tolower)->test_dat
test_dat |>
  dplyr::mutate(Collection_Date=as.Date(Collection_Date,format="%Y-%m-%d")) -> test_dat

#load in the species lookup
# Species_Lookup <- readRDS(file = "Development_Speccies_Class/Species_Lookup_20240531.rds")
load(file = "data/Species_Lookup_20240806.rda")
Species_Lookup <- Species_Lookup_20240806

#add some empty columns in the test dataset
test_dat$family <- NA
test_dat$order <- NA
test_dat$scientific.name <- NA

# manually loop through the dataset. This is the old way that
# my new function will hopefully clean up and automate.

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

clean_test_data <- test_dat

usethis::use_data(clean_test_data, overwrite = TRUE)
