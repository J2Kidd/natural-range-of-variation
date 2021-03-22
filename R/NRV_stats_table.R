#' NRV Stats Table
#'
#' Generate NRV calculations and summary stats
#'
#' @param dataFrame The data frame that contains the information formatted for the function
#'
#' @return Table with the NRV thresholds and associated summary statistics
#' @import tidyverse
#' @import dplyr
#' @export
NRV_stats_table<-function(dataFrame) {
  dataFrame%>%
    group_by(Site,Parameter)%>%
    do(NRV_stats(.))%>%
    ungroup()
}
