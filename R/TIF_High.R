#' Upper Tukey Inner Fence (TIF) Threshold
#'
#'Calculate upper thresholds of TIF calculation
#'
#' @param x The results column that includes results below the detection limit as half the detection limit
#'@param na.rm Default handle NA values
#' @return Upper threshold value
#' @importFrom stats quantile IQR
#' @export

TIF_High <- function(x, na.rm = TRUE) { # Adding na.rm parameter
  TIF <- (stats::quantile(x, 0.75, names = FALSE, na.rm = na.rm)) + (1.5*(stats::IQR(x, na.rm = na.rm)))
  return(TIF)
}





