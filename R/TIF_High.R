#' Upper Tukey Inner Fence (TIF) Threshold
#'
#' Calculate upper threshold of TIF calculation
#' Function removes NA values
#'
#' @param x Numeric vector of water quality parameter values (results column that includes results below the detection limit as half the detection limit)
#' @return Upper threshold value
#' @importFrom stats quantile IQR
#' @export

TIF_High <- function(x) {
  TIF <- (stats::quantile(x, 0.75, names = FALSE, na.rm = TRUE)) + (1.5 * (stats::IQR(x, na.rm = TRUE)))
  return(TIF)
}





