#' Load the classification model.
#'
#' Loads a pre-trained persistent binary classification model to classify customers as "PHOTOGRAPHERS" or "OTHERS".
#'
#' @param mtype Type of the model to be returned. Valid value [svm | rf | gbm]. Defaults to the highest accuracy gbm model.
#' 
#' @return a caret::train binary classification model object trained using specified model types.
#' 
#' @examples 
#'     load.model()
#'     load.model(mtype="rf")
#'     
#' @import caret
#' 
#' @export
load.model <- function(mtype="gbm") {
  # Find location of correct stored model file from data directory of the package.
  model.location <- system.file("data", paste0(mtype,".rds"), package="PhotographerModels")
  
  # Read and return model from rds file.
  model <- readRDS(model.location)
  return(model)
}
