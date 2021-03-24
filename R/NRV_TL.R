#' NRV_TL Example Data Frame
#'
#' A data Frame prepared from raw data extracted from the Mackenzie DataStream site. The NRV function will only work on data frames formatted with the same column names and labels
#'
#' @format A data frame with 653 rows and 7 variables:
#' \describe{
#'   \item{Site}{name of the waterbody samples were collected from}
#'   \item{Date}{Date sample was collected}
#'   \item{Parameter}{Water quality parameter, combined with fraction (if applicable)}
#'   \item{DL}{Detection Limit: Value of the analysis detection limit}
#'   \item{RDC}{Result Detection Condition: BDL if result "below the detection limit", NUM if result was above the detection limit}
#'   \item{ResultRaw}{Analysis result, blank if result was below the detection limit}
#'   \item{ResultCalc}{Analysis result, half the detection limit value if result was below the detection limit}
#'
#'
#'
#'   ...
#' }
#' @source \url{https://mackenziedatastream.ca/}
"NRV_TL"
