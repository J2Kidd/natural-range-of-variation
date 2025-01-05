#' M2M_High
#'#'Calculate lower threshold of Median±2MA calculation
#'Function used in NRV calculation function
#'Function removes NA values
#' @param x The results column that includes results below the detection limit as half the detection limit
#'
#'
#' @return lower threshold of Median±2MAD calculation
#' @importFrom stats median mad
#' @export
#'
M2M_Low <- function(x) {
  M2M <- (stats::median(x, na.rm=TRUE)) - (2*(stats::mad(x, na.rm = TRUE)) )
  return(max(M2M, 0)) #returns a 0 if the number is negative
}

