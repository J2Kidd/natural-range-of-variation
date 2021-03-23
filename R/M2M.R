#' Calculate Median ±2 Mean Absolute Deviation (MAD)
#'
#'Calculate the upper and lower range of the natural range of variation (NRV) for a given parameter with the Median ±2 mean absolute deviation calculation
#'
#' @param x A water quality parameter
#'
#' @return The lower and higher threshold of the natural range of variation for the parameter
#' @importFrom stats median mad
#' @export
#'
M2M <- function(x) {
  M2M_Low <- (stats::median(x, na.rm=TRUE)) - (2*(stats::mad(x, na.rm = TRUE)) )
  M2M_High <- (stats::median(x, na.rm=TRUE)) + (2*(stats::mad(x, na.rm = TRUE)) )
  names(M2M_Low)<-"Lower"
  names(M2M_High)<-"Upper"
  M2M_range<-c(M2M_Low, M2M_High)
  return(M2M_range)
}
