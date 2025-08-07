#' M2M_LowLog
#' Calculate lower threshold of Median±2MAD calculation on data using the natural logarithm (ie.., log())
#' The calculation returns the value transformed back to its original scale using the exp() function
#' The calculation returns the value as 0 if the result is a negative number
#' Function used in NRV calculation function
#' Function removes NA values
#' @param x The results column that includes results below the detection limit as half the detection limit and is log-transformed using the natural logarithm
#'
#' @return lower threshold of Median±2MAD calculation that is back-transformed to its original scale
#' @importFrom stats median mad
#' @export
#'
M2M_LowLog <- function(x) {
  M2M_Log <- (stats::median(x, na.rm = TRUE)) - (2 * (stats::mad(x, na.rm = TRUE, constant = 1)) )
  M2M <- exp(M2M_Log)  # Back-transform
  return(max(M2M, 0))
}
