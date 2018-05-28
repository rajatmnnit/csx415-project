library(testthat)

member_guid <- c("abcd", "xyzz")
lr_cc_usage	<- c(0, 10)
lr_cl_usage	<- c(10, 2)
lr_mo_usage	<- c(0, 8)
storage_usage	<- c(0, 800)
ps_usage <- c(3, 0)
stock_usage <- c(0, 0)
df <- data.frame(member_guid, lr_cc_usage, lr_cl_usage, lr_mo_usage, storage_usage, ps_usage, stock_usage)

test_that("classify using default model", {
  predicted <- classify(df)
  expect_equal(as.character(predicted[1,"class"]), "PHOTOGRAPHER")
})

test_that("classify using gbm model", {
  predicted <- classify(df, "gbm")
  expect_equal(as.character(predicted[1,"class"]), "PHOTOGRAPHER")
})

test_that("classify using svm model", {
  predicted <- classify(df, "svm")
  expect_equal(as.character(predicted[1,"class"]), "OTHER")
})

test_that("classify using rf model", {
  predicted <- classify(df, "rf")
  expect_equal(as.character(predicted[1,"class"]), "PHOTOGRAPHER")
})
