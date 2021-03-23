#' CCME Freshwater Aquatic Life Guidelines
#'
#' A dataset containing the CCME freshwater aquatic life guidelines for various parameters
#'
#' @format A data frame with 17 rows and 4 variables:
#' \describe{
#'   \item{parameter}{water quality parameter}
#'   \item{value}{guideline value}
#'   \item{description}{type of guideline}
#'   \item{dependencies}(Y if guideline is calculated based on site-specific conditions (e.g., hardness or ph), N if there is one standard guideline)
#'
#'   ...
#' }
#' @source \url{https://www.ccme.ca/en/resources/pollution_prevention.html}
"CCME"
