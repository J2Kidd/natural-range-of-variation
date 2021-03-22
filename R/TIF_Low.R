#' Upper Tukey Inner Fence (TIF) Threshold
#'
#' Calculate upper thresholds of TIF calculation
#'
#' @param resultCalc The results column that includes results below the detection limit as half the detection limit
#'
#' @return Lower threshold value
#' @importFrom stats quantile IQR
#' @export
TIF_Low <- function(resultCalc) {
  TIF <- (quantile(resultCalc,0.25, names=FALSE)) - (IQR(resultCalc)*1.5)
  return(TIF)
}
