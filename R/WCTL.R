#' WCTL Example Dataset
#'
#' A dataset prepared using the NRV_summ_df function (see WC for example original dataset)
#'
#' @format A data frame with 1475 rows and 7 variables:
#' \describe{
#'   \item{Site}{name of the waterbody samples were collected from}
#'   \item{Date}{Date sample was collected}
#'   \item{Parameter}{Water quality parameter, combined with fraction (if applicable)}
#'   \item{ResultRaw}{Analysis result, NA if result was below the detection limit}
#'   \item{ResultCalc}{Analysis result, half the detection limit value if result was below the detection limit}
#'   \item{RDC}{BDL if result "below the detection limit", NUM if result was above the detection limit}
#'   \item{DL}{Value of the analysis detection limit}
#'
#'
#'   ...
#' }
#' @source \url{https://mackenziedatastream.ca/}
"WCTL"
