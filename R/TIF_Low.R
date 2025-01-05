#' Upper Tukey Inner Fence (TIF) Threshold
#'
#' Calculate upper thresholds of TIF calculation
#'
#' @param x The results column that includes results below the detection limit as half the detection limit
#'
#' @return Lower threshold value
#' @importFrom stats quantile IQR
#' @export
TIF_Low <- function(x) {
  TIF <- (stats::quantile(x, 0.25, names=FALSE)) - (stats::IQR(x) * 1.5)
  return(max(TIF, 0)) #returns a 0 if the number is negative
}
