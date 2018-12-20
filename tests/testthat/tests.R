#  Test URL Constructors
library(testthat)

test_that("url constructors work", {
  expect_equal(get_url("token", "budgets"),
               "https://api.youneedabudget.com/v1/budgets/?access_token=token")
  expect_error(get_url("token", "budget"))
  expect_equal(get_url("token", "categories", 1234, "months", 1),
               "https://api.youneedabudget.com/v1/months/1/categories/1234?access_token=token")
  expect_error(get_url("token", "budgets", 1234, "months", 1))
  expect_error(get_url("token", "categories", 1234, "transactions", 1))
})
