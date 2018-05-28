#' Classify new data based on trained models.
#'
#' Classify new customers as "PHOTOGRAPHERS" or "OTHERS" by scoring against a pre-trained persistent binary classification model.
#'
#' @param data  Data frame containing new data with structure [member_guid, lr_cc_usage, lr_cl_usage, lr_mo_usage, storage_usage, ps_usage, stock_usage].
#' @param mtype Type of the model to be used for classification. Valid value [svm | rf | gbm]. Defaults to the highest accuracy gbm model.
#' 
#' @return a data frame of the format [member_guid, class], where "class" is the predicted class from model for the corresponding member_guid.
#' 
#' @examples 
#'     classify(new.data)
#'     classify(new.data, mtype="rf")
#'     
#' @import PhotographerModels
#' 
#' @export
classify <- function(data, mtype="gbm") {
  # Load the model from PhotographerModels based on the selected model type.
  fit <- load.model(mtype);
  
  # Predict results for new data.
  data$class <- predict(fit, newdata=data, type="raw")
  
  # Retuen only the member_guid, predicted class.
  return(data[,c(1,8)])
}
