#' Perform Shapiro-Wilk Test
#'
#' This function performs the Shapiro-Wilk test on a given data vector.
#'
#' @param data_vector A numeric vector for which the Shapiro-Wilk test will be performed.
#'
#' @return A list with the Shapiro-Wilk test results.
#' @importFrom stats var
#' @export
#'
#' @examples
#' perform_sw_test(rnorm(100))
perform_sw_test <- function(data_vector) {
  # function body
}


perform_sw_test <- function(data_vector) {
  clean_data_vector <- na.omit(data_vector)
  if(length(clean_data_vector) > 3 & length(clean_data_vector) < 5000) {  # Check for valid input size
    # Check if there is variance in the data
    if (var(clean_data_vector) != 0) {
      sw_test_result <- shapiro.test(clean_data_vector)
      p_value_formatted <- sprintf("%.4f", sw_test_result$p.value)  # Format the p-value
      return(p_value_formatted)
    } else {
      # Return NA (or another placeholder) if no variance
      return(NA_character_)
    }
  } else {
    return(NA_character_)  # Return NA for inputs that don't meet size requirements
  }
}
