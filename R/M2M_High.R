#' M2M_High
#'Calculate upper threshold of Median±2MA calculation
#'Function used in NRV calculation function
#'Function removes NA values
#' @param resultCalc The results column that includes results below the detection limit as half the detection limit
#'
#' @return upper threshold of Median±2MAD calculation
#' @importFrom stats median mad
#' @export
#'
M2M_High <- function(resultCalc) {
  M2M <- (median(resultCalc, na.rm=TRUE)) + (2*(mad(resultCalc, na.rm = TRUE)) )
  return(M2M)
}
