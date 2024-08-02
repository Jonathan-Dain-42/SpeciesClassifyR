test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("classify_species.scientific wors",{
  data("clean_test_data")
  data("scientific.name_data_clean")
  expect_equal(classify_species.scientific(data = clean_test_data,species_col = "scientific.name"),scientific.name_data_clean)
})
