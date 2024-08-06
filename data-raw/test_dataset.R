# read in the test data
test_dat <- readRDS(file = "Development_Speccies_Class/Testing_Data.rds")

test_dat |>
  dplyr::mutate_all(.funs=tolower)->test_dat

test_dat |>
  dplyr::mutate(Collection_Date=as.Date(Collection_Date,format="%Y-%m-%d")) -> test_dat

usethis::use_data(test_dat, overwrite = T)
