

#' Load the model corresponding to the given argument.
#'
#' Takes in a model type. Valid model types are : linearsvm, gbm, ...
#' @param mtype
#' @return
#' @export
load.model <- function(mtype) {
  model <- readRDS("/Users/rajatj/csx415/csx415-project/photographer_classifier/pkgs/PhotographerModels/data/linear_svm.rds")
  return(model)
}
