#' TIF Calculation
#'
#' Used to calculate the lower and upper natural range of variation (NRV) thresholds for a single parameter
#'
#' @param x Numeric vector of water quality parameter values (results column that includes results below the detection limit as half the detection limit)
#'
#' @return upper and lower thresholds of NRV
#' @importFrom stats quantile IQR
#' @export
#'
TIF_calc <- function(x) {
  TIF_Low <- (stats::quantile(x, 0.25, names = FALSE, na.rm = TRUE)) - (1.5 * (stats::IQR(x, na.rm = TRUE)))
  TIF_High <- (stats::quantile(x, 0.75, names = FALSE, na.rm = TRUE)) + (1.5 * (stats::IQR(x, na.rm = TRUE)))
  names(TIF_Low) <- "Lower"
  names(TIF_High) <- "Upper"
  TIF_range <- c(TIF_Low, TIF_High)
  return(TIF_range)
}
