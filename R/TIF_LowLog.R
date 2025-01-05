#' Lower Tukey Inner Fence (TIF) Threshold
#'
#'Calculate lower thresholds of TIF calculation on data transformed using the natural logarithm (i.e., log())
#'
#' @param x The results column that includes results below the detection limit as half the detection limit
#'
#' @return Lower threshold value that is back-transformed to its original scale
#' @importFrom stats quantile IQR
#' @export
TIF_LowLog <- function(x) {
  TIF_Log <- (stats::quantile(x,0.75, names=FALSE)) - (stats::IQR(x)*1.5)
  TIF <- exp(TIF_Log)  # Back-transform
  return(TIF)
}
