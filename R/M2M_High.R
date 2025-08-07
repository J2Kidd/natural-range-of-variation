#' M2M_High
#' Calculate upper threshold of Median±2MAD calculation
#' Function used in NRV calculation function
#' Function removes NA values
#' @param x Numeric vector of water quality parameter values (results column that includes results below the detection limit as half the detection limit)
#'
#' @return upper threshold of Median±2MAD calculation
#' @importFrom stats median mad
#' @export
#'
M2M_High <- function(x) {
  M2M <- (stats::median(x, na.rm = TRUE)) + (2 * (stats::mad(x, na.rm = TRUE, constant = 1)) )
  return(M2M)
}
