#' Calculate Median ±2 Median Absolute Deviation (MAD)
#'
#' Calculate the upper and lower range of the natural range of variation (NRV) for a given parameter with the Median ±2 median absolute deviation calculation
#'
#' @param x Numeric vector of water quality parameter values (results column that includes results below the detection limit as half the detection limit)
#'
#' @return The lower and higher threshold of the natural range of variation for the parameter
#' @importFrom stats median mad
#' @export
#'
M2M <- function(x) {
  M2M_Low <- (stats::median(x, na.rm = TRUE)) - (2 * (stats::mad(x, na.rm = TRUE, constant = 1)) )
  M2M_High <- (stats::median(x, na.rm = TRUE)) + (2 * (stats::mad(x, na.rm = TRUE, constant = 1)) )
  names(M2M_Low) <- "Lower"
  names(M2M_High) <- "Upper"
  M2M_range <- c(M2M_Low, M2M_High)
  return(M2M_range)
}
