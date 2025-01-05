#' NRV Boxplot Data Frame
#'
#'Create data frame for boxplot function
#'Parameters need to be presented as individual columns (using the spread functon) after removing redundant columns

#' @param x Data frame that the summary stats were generated from
#'
#' @return Data frame that the boxplot function can be run on
#' @importFrom tidyr spread
#' @importFrom dplyr select %>%
#' @export

NRV_box_df<-function(x) {

  x<-x %>%
    dplyr::select(-c(x$ResultRaw,x$RDC,x$DL))%>%
    tidyr::spread(x$Parameter, x$ResultCalc)

}
