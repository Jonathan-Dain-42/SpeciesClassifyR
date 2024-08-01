test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})


test_that("Days to run function works",{
  expect_equal(days_to_run(total_steps=200000000,hours_per_million = 0.49),
               'Hello there! Your BEAST run should finish in  4.083  days.')
})
