#' Get the CCME guideline for the selected parameter
#'
#'#Get the CCME guideline for the selected parameter
#Function selects the guidelines based on CCME guidelines for applicable parameters and calculates guidelines using mean hardness values
#Function used by the boxplot function, so must be run BEFORE the boxplot function is used
#Must have dataset formatted based on structure presented in README.md file
#Many guidelines are calculated based on hardness
#Units for metals guidelines are in ug/L

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
    return(sqldf(query))
  }
}
