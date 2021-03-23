#' Upper Tukey Inner Fence (TIF) Threshold
#'
#'Calculate upper thresholds of TIF calculation
#'
#' @param resultCalc The results column that includes results below the detection limit as half the detection limit
#'
#' @return Upper threshold value
#' @importFrom stats quantile IQR
#' @export
TIF_High <- function(resultCalc) {
  TIF <- (stats::quantile(resultCalc,0.75, names=FALSE)) + (stats::IQR(resultCalc)*1.5)
  return(TIF)
}
