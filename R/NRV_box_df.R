#' NRV Boxplot Data Frame
#'
#'Create data frame for boxplot function
#'Parameters need to be presented as individual columns (using the spread functon) after removing redundant columns

#' @param x Data frame that the summary stats were generated from
#'
#' @return Data frame that the boxplot function can be run on
#' @import tidyverse
#' @export

NRV_box_df<-function(x) {

  x<-x %>%
    select(-c(ResultRaw,RDC,DL))%>%
    spread(Parameter, ResultCalc)

}
