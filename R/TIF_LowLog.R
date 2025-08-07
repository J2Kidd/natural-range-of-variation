#' Lower Tukey Inner Fence (TIF) Threshold on log-transformed data
#'
#' Calculate lower threshold of TIF calculation on data transformed using the natural logarithm (i.e., log())
#' Function removes NA values
#' The calculation returns the value as 0 if the result is a negative number
#'
#' @param x Numeric vector of water quality parameter values (results column that includes results below the detection limit as half the detection limit and is log-transformed using the natural logarithm)
#'
#' @return Lower threshold value that is back-transformed to its original scale
#' @importFrom stats quantile IQR
#' @export
TIF_LowLog <- function(x) {
  TIF_Log <- (stats::quantile(x, 0.25, names = FALSE, na.rm = TRUE)) - (1.5 * (stats::IQR(x, na.rm = TRUE)))
  TIF <- exp(TIF_Log)  # Back-transform
  return(max(TIF, 0))
}
