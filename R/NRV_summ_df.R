#' NRV summary data frame
#'
#'Prepare your data frame to be read by the NRV package's functions
#'Data frame needs to be formatted with specific column names and parameter names
#'Generates new column RDC (resultDetectionCondition) that identifies whether there result is above or below the detection limit
#'Generates a new column (ResultCalc) that presents the raw result for values above the detection limit, and values that are half the detection limit if result is below the detection limit
#'This function allows you to enter your current column names to be renamed to fit with the functions
#'Must enter each column title with the name of the data frame then column title (e.g., df$columnTitle)

#'make sure detection limit column is numeric
#'
#' @param site Column with site name or ID
#' @param date Column with sampling date
#' @param parameter Column with parameter/variable name (e.g., pH, iron, calcium)
#' @param fraction Column with analysis fraction details (e.g., total, dissolved)
#' @param detectionLimit Column with the value of the detection limit for the analyses
#' @param detectionCondition Column that identifies whether the results is below the detection limit. Space should be empty if result is not below the detection limit, if result is below the detection limit should read: below detection limit
#' @param result Column with raw result values
#'
#' @return Data frame that subsequent functions can read to calculate the NRV and summary statistics
#' @import stringr dplyr
#' @export
#'
NRV_summ_df<-function(site,date,parameter,fraction,detectionLimit,detectionCondition,result) {

  # Remove the characters we dont want
  parameter = tolower(parameter)
  fraction = tolower(fraction)
  parameter = str_replace_all(parameter," ","_")
  parameter = str_replace_all(parameter,",","")
  parameter = str_replace_all(parameter,"\\.","_")
  parameter = gsub("\\(|\\)", "", parameter)

  fraction = str_replace_all(fraction," ","_")
  fraction = str_replace_all(fraction,",","")
  fraction = str_replace_all(fraction,"\\.","_")
  fraction = gsub("\\(|\\)", "", fraction)

  #generate the field we want from the combination of parameter and fraction
  parameter = paste(parameter,fraction,sep="_",collapse = NULL)
  parameter = str_replace_all(parameter,"_NA","")

  #create the final table of clean data
  tibble("Site" = site,
         "Date" = date,
         "Parameter" = parameter,
         "DL" = detectionLimit,
         "RDC" = detectionCondition, #BDL or NUM are the acceptable values for this column
         "ResultRaw" =ifelse(detectionCondition %in% "BDL",detectionLimit,result),
         "ResultCalc" =ifelse(detectionCondition %in% "BDL",detectionLimit/2,result))

}
