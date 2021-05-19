#' CCME Freshwater Aquatic Life guidelines
#'
#'The function retrieves guideline values from the CCME table for each matching parameter in your data frame.
#'This Function is used by the NRV function to render guidelines on boxplots.
#'You must download the CCME table from the package's git repository and manually edit the site-specific guidelines.
#'Once you have reviewed the CCME table and edited for your site, then read it into your R session.
#'Ensure the CCME table is labeled: CCME.
#'
#' @param param The name of the parameter, which must be in the exact format/spelling presented in the parameter list in the README.md file
#'
#' @return Generates guidelines values to be presented in the boxplots
#' @import sqldf
#' @export
#'
getParamGuideline<-function(param) {
  res = NULL

  ## if the CCME guidelines have not been loaded, produce a warning and return null so nothing is rendered
  if(is.null(CCME)) {
    warning(paste("No guideline could be found for given param as the CCME guidelines have not been imported yet or[see Readme file for instructions]: ", param))
    return(res)
  }
  else {
    match = as.list(strsplit(param, "_")[[1]])
    query = paste("select * from CCME where parameter like '",match[1],"%'",sep="")
    return(sqldf::sqldf(query))
  }
}
