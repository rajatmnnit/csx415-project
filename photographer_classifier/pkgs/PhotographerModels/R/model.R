#' Load the classification model.
#'
#' Loads a pre-trained persistent binary classification model to classify customers as "PHOTOGRAPHERS" or "OTHERS".
#'
#' @param mtype Type of the model to be returned. Valid value [svm | rf | gbm]. Defaults to the highest accuracy gbm model.
#' @return a caret::train binary classification model object trained using specified model types.
#' @export
load.model <- function(mtype="gbm") {
  model.location = paste0("/Users/rajatj/csx415/csx415-project/photographer_classifier/pkgs/PhotographerModels/data/", mtype, ".rds")
  model <- readRDS(model.location)
  return(model)
}
