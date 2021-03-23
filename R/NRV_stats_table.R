#' NRV Stats Table
#'
#' Generate NRV calculations and summary stats
#'
#' @param dataFrame The data frame that contains the information formatted for the function
#'
#' @return Table with the NRV thresholds and associated summary statistics
#' @importFrom dplyr group_by do ungroup
#' @export
NRV_stats_table<-function(dataFrame) {
  Site<-Parameter<-NULL
  dataFrame%>%
    dplyr::group_by(Site,Parameter)%>%
    dplyr::do(NRV_stats(.))%>%
    dplyr::ungroup()
}
