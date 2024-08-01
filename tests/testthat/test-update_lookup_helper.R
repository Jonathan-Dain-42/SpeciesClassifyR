test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("Make sure update_lookup_helper works",{
  #load the test data
  data("update_test_dataset")
  #load the clean test data
  data("update_clean_dataset")
  #test for equality
  expect_equal(update_lookup(common.name = "mallard",type = "dabbling duck",scientific.name = "anas platyrhynchos",english.name.ebird = 'mallard',order = 'anseriformes',family = 'anatidae (ducks, geese, and waterfowl)',domestic = "wild"),update_clean_dataset)})
