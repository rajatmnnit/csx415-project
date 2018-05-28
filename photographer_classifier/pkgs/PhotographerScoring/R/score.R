library(PhotographerModels)
library(caret)

#' Classify new data based on trained models.
#'
#' Classify new customers as "PHOTOGRAPHERS" or "OTHERS" by scorin against a pre-trained persistent binary classification model.
#'
#' @param data  New data with structure [].
#' @param mtype Type of the model to be returned. Valid value [svm | rf | gbm]. Defaults to the highest accuracy gbm model.
#' @return a caret::train binary classification model object trained using specified model types.
#' @export
classify <- function(data, mtype="gbm") {
  fit <- load.model(mtype);
  
  data$class <- predict(fit, newdata=data, type="raw")
  data[,c(1,8)]
}
