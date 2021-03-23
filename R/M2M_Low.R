#' M2M_High
#'#'Calculate lower threshold of Median±2MA calculation
#'Function used in NRV calculation function
#'Function removes NA values
#' @param resultCalc The results column that includes results below the detection limit as half the detection limit
#'
#'
#' @return lower threshold of Median±2MAD calculation
#' @importFrom stats median mad
#' @export
#'
M2M_Low <- function(resultCalc) {
  M2M <- (stats::median(resultCalc, na.rm=TRUE)) - (2*(stats::mad(resultCalc, na.rm = TRUE)) )
  return(M2M)
}
