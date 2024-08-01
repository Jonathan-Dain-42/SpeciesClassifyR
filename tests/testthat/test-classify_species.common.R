test_that("Make sure classify_species.common works",{
#load the test data
  data("test_dat")
#load the clean test data
  data("clean_test_data")
  expect_equal(classify_species.common(data =test_dat,species_col = "Species"),clean_test_data)})
