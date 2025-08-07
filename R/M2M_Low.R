#' M2M_Low
#' Calculate lower threshold of Median±2MAD calculation
#' The calculation returns the value as 0 if the result is a negative number
#' Function used in NRV calculation function
#' Function removes NA values
#' @param x Numeric vector of water quality parameter values (results column that includes results below the detection limit as half the detection limit)
#'
#'
#' @return lower threshold of Median±2MAD calculation
#' @importFrom stats median mad
#' @export
#'
M2M_Low <- function(x) {
  M2M <- (stats::median(x, na.rm = TRUE)) - (2 * (stats::mad(x, na.rm = TRUE, constant = 1)) )
  return(max(M2M, 0)) #returns a 0 if the number is negative
}

