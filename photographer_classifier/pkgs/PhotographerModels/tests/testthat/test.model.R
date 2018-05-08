library(testthat)

test_that("load.model default is gbm", {
  model.default <- load.model()
  expect_equal(model.default$method, "gbm")
})

test_that("load.model of gbm is gbm", {
  model.gbm <- load.model("gbm")
  expect_equal(model.gbm$method, "gbm")
})

test_that("load.model of svm is svm", {
  model.svm <- load.model("svm")
  expect_equal(model.svm$method, "svmLinear")
})

test_that("load.model of rf is rf", {
  model.rf <- load.model("rf")
  expect_equal(model.rf$method, "rf")
})
