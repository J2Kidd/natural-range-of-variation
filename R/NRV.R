#' Natural Range of Variation
#'
#'Notes: edit to have 1 dataFrame but multiple sites (i.e., run analyses for each siteID)
#'Calculate NRV summary table and generate boxplots
#'Can turn off boxplots with generateplots=FALSE (default =TRUE)
#'Can turn off guidelines for boxplots with renderGuideline=FALSE (default =TRUE)
#'
#' @param inputDatas Single data frame that contains information for each site, or multiple data frames if site data are separated
#' @param parameters Default is NULL, which will run the function on each unique parameter in the data frame. Option to select specific parameters from the data frame.
#' @param generateplots Default is TRUE, which will generate box plots for each parameter in the data frame (unless specific parameters are provided for the "parameter" argument). Set to FALSE if you do not want box plots generated
#' @param renderGuideline Default set to TRUE, which will render all applicable guidelines for each parameter. See the CCME table to confirm the guidelines are appropriate for your dataset. Set to FALSE if the guideline skews the image of the box plot (e.g., guideline is an order of magnitude larger than your maximum value)
#'
#' @return Summary table of results and boxplots for all specified parameters
#' @import ggplot2
#' @import sqldf
#' @import dplyr
#' @export
#'
NRV <- function(inputDatas,parameters=NULL,generateplots=TRUE,renderGuideline=TRUE) {
  count = 0
  totalNRV = NULL

  ## if there are multiple dataframe passed in, merge them into one
  for(NRV in inputDatas) {
    if(count > 0) {
      totalNRV<-rbind(NRV,totalNRV)
    }
    else {
      totalNRV = NRV
    }
    count = count + 1
  }


  ## generates the summary data for all dataframe at once
  NRV_table<-NRV_stats_table(totalNRV)
  view(NRV_table)

  if(generateplots == TRUE) {
    boxes<-NRV_box_df(totalNRV)
    ## cast date objects to string objects so sqldf doesnt try reformat them
    boxes$Date <- as.character(boxes$Date)

    if(is.null(parameters)) {
      parameters = sqldf("select distinct Parameter from NRV_table")
      parameters = parameters$Parameter
    }

    for(parameter in parameters) {
      CCME_values = getParamGuideline(parameter)
      # ensure the values in the table are being treated as numeric values rather than characters
      CCME_values$value = as.numeric(CCME_values$value)

      query = paste("select Site,`Date`,",parameter," from boxes where ",parameter," is not null",sep="");
      box<-sqldf(query)

      NRV_Box <- ggplot(box, aes(x=Site, y=get(parameter), fill=Site)) +
        geom_boxplot()+
        labs(x="Site", y = parameter, fill="Site")

      if(renderGuideline == TRUE) {
        # avoid non-descript warnings when there are no CCME values for this param
        if(nrow(CCME_values) > 0) {
          for(i in 1:nrow(CCME_values)) {
            NRV_Box = NRV_Box + geom_hline(yintercept=CCME_values[i,2], linetype="dashed", color = "red")
          }
        } else {
          warning(paste("No CCME value could be found for param: ",parameter))
        }
      }

      NRV_Box = NRV_Box + scale_fill_brewer(palette="Blues") + theme_classic() + theme(text = element_text(size=12))

      print(NRV_Box)
    }
  }

  return(NRV_table)
}
