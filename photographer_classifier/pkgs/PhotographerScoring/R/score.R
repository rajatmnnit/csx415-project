library(PhotographerModels)
library(caret)

#' Classify new data based on trained models.
#'
#' Classify new customers as "PHOTOGRAPHERS" or "OTHERS" by scorin against a pre-trained persistent binary classification model.
#'
#' @param data  Data frame containing new data with structure [member_guid, lr_cc_usage, lr_cl_usage, lr_mo_usage, storage_usage, ps_usage, stock_usage].
#' @param mtype Type of the model to be used for classification. Valid value [svm | rf | gbm]. Defaults to the highest accuracy gbm model.
#' @return a data frame of the format [member_guid, class], where "class" is the predicted class from model for the corresponding member_guid.
#' @export
classify <- function(data, mtype="gbm") {
  fit <- load.model(mtype);
  
  data$class <- predict(fit, newdata=data, type="raw")
  data[,c(1,8)]
}
