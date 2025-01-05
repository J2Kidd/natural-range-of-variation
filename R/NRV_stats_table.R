#' NRV Stats Table
#'
#' Generate NRV calculations and summary stats
#'
#' @param dataFrame The data frame that contains the information formatted for the function
#' @param data_type The data type is set as reference or impacted in the NRV function by the user. Default is reference.
#'
#' @return Table with the NRV thresholds and associated summary statistics
#' @importFrom dplyr group_by do ungroup %>%
#' @export
NRV_stats_table <- function(dataFrame, data_type = "reference") { # Include data_type parameter with default
  Site <- Parameter <- NULL
  dataFrame %>%
    dplyr::group_by(Parameter) %>%
    dplyr::do(NRV_stats(., data_type = data_type)) %>% # Pass data_type to NRV_stats
    dplyr::ungroup()
}
