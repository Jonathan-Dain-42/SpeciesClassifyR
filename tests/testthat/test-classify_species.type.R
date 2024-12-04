test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})


test_that("Make sure classify_species.type works",{
  #load the test data
  data("test_dat")
  SpeciesClassifyR::classify_species.common(data = test_dat,species_col = "Species")->obj
  #load the clean test data
  data("type_clean_dataset")
  #test for equality
  expect_equal(classify_species.type(data = obj,species_col = "scientific.name"),type_clean_dataset)})
