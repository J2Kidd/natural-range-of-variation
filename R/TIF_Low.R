#' Lower Tukey Inner Fence (TIF) Threshold
#'
#' Calculate lower threshold of TIF calculation
#' Function removes NA values
#' The calculation returns the value as 0 if the result is a negative number
#'
#' @param x Numeric vector of water quality parameter values (results column that includes results below the detection limit as half the detection limit)
#'
#' @return Lower threshold value
#' @importFrom stats quantile IQR
#' @export
TIF_Low <- function(x) {
  TIF <- (stats::quantile(x, 0.25, names = FALSE, na.rm = TRUE)) - (1.5 * (stats::IQR(x, na.rm = TRUE)))
  return(max(TIF, 0)) #returns a 0 if the number is negative
}
