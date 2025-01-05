#' Natural Range of Variation
#'
#'This function generates a table with the NRV thresholds and associated summary statistics for each parameter in your data frame.
#'
#'By default, the function also generates box plots for each parameter in your data frame. Can turn off boxplots with generateplots=FALSE (default =TRUE)
#'You can also select specific parameters to run the boxplots on. E.g., NRV(list(NRV_WC,NRV_TL),"ph","alkalinity_total")
#'By default, the function renders guidelines from the CCME table (see README file). Turn off guidelines for box plots with renderGuideline=FALSE
#'You must upload the CCME.csv file from the package's git repository (use readr, change value column to character data type)
#'
#' @param inputData Data frame that contains sample data to be included in the NRV calculation
#' @param data_type The user has to choose if they are using "reference" site data or "impacted" data that may contain samples from impacted sites. Default is "reference"
#'
#' @return Summary table of results all unique parameters
#' @import tibble
#' @export
#'
NRV <- function(inputData, data_type = "reference") {
  # Call NRV_stats_table to process the entire inputData,
  # which handles each unique Parameter internally.
  results_table <- NRV_stats_table(inputData, data_type = data_type)

  # View the complete results table. This replaces the earlier per-parameter viewing
  # and is suitable for scenarios where reviewing the full set of results at once is appropriate.
  # tibble::view is typically used in an interactive R session, and may not work as expected
  # in non-interactive environments. In such cases, consider using print() instead.
  tibble::view(results_table)

}
