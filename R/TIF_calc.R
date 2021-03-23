#' TIF Calculation
#'
#' Used to calculate the lower and upper natural range of variation (NRV) thresholds for a single parameter
#'
#' @param x Water quality parameter
#' @param na.rm Default handle NA values
#'
#' @return upper and lower thresholds of NRV
#' @importFrom stats quantile IQR
#' @export
#'
TIF_calc <- function(x, na.rm = TRUE) {
  TIF_Low <- (stats::quantile(x,0.25, names=FALSE)) - (stats::IQR(x)*1.5)
  TIF_High <- (stats::quantile(x,0.75, names=FALSE)) + (stats::IQR(x)*1.5)
  names(TIF_Low)<-"Lower"
  names(TIF_High)<-"Upper"
  TIF_range<-c(TIF_Low, TIF_High)
  return(TIF_range)
}
