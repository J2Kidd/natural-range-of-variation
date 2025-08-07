#' Create Time Series Plots for NRV
#'
#' This function generates time series plots for the specified parameter across all unique parameters
#' in the dataset or for a specific parameter. It allows the specification of a season,
#' and displays threshold lines based on input data frames.
#'
#' @param dataDF data frame containing the time series data
#' @param thresholdDF data frame containing the threshold values for the parameters
#' @param paramName name of the parameter to plot; "ALL" indicates that plots should be generated for all parameters
#' @param season label for the season to be included in the x-axis title
#' @param NRVmethod TIF or M2MAD based on the NRV calculation method you have selected for your study (default is "TIF")
#' @importFrom ggplot2 ggplot element_rect guide_legend aes geom_jitter position_jitter labs scale_x_date theme_classic scale_y_continuous theme guides scale_linetype_manual geom_hline
#' @importFrom scales date_format
#' @export

NRVTimeSeries <- function(dataDF, thresholdDF, paramName = "ALL", season = "Open-Water", NRVmethod ="TIF") {
  suppressWarnings({
    if (toupper(paramName) == "ALL") {
      uniqueParameters <- unique(dataDF$Parameter)
      for (param in uniqueParameters) {
        NRVTimeSeries_individual(dataDF, param, thresholdDF, season, NRVmethod)  # Pass season to the individual function
      }
    } else {
      NRVTimeSeries_individual(dataDF, paramName, thresholdDF, season, NRVmethod)  # Pass season to the individual function
    }
  })
}

NRVTimeSeries_individual <- function(dataDF, paramName, thresholdDF, season, NRVmethod) {
  suppressWarnings({
    if (!(paramName %in% dataDF$Parameter) || !(paramName %in% thresholdDF$Parameter)) {
      stop("Parameter not found in one of the data frames!")
    }

    thresholds <- subset(thresholdDF, Parameter == paramName)
    plotData <- subset(dataDF, Parameter == paramName)

    # Select which thresholds to use based on NRVmethod
    if (NRVmethod == "TIF") {
      lower_col <- "TIF_lowerThreshold"
      upper_col <- "TIF_upperThreshold"
    } else if (NRVmethod == "M2MAD") {
      lower_col <- "M2MAD_lowerThreshold"
      upper_col <- "M2MAD_upperThreshold"
    } else {
      stop("Method must be either 'TIF' or 'M2MAD'")
    }

    plot <- ggplot(plotData, aes(x = Date, y = ResultCalc, color = Site)) +
      geom_jitter(position = position_jitter(width = 125, height = 0), size = 3) +
      labs(x = paste("Year (", season, " Season)", sep=""), y = paste(paramName, "mg/L"), color = "Site") +
      scale_x_date(date_breaks = "1 year", labels = date_format("%Y")) +
      theme_classic(base_size = 20) +
      scale_y_continuous(labels = function(x) format(x, scientific = FALSE), limits = c(0, NA)) +
      theme(panel.border = element_rect(linewidth = 2, fill = NA, color = "black")) +
      guides(color = guide_legend(title = NULL), linetype = guide_legend(title = NULL, override.aes = list(color = c("black", "black")))) +
      scale_linetype_manual(values = c("NRV Threshold, Lower" = "dashed", "NRV Threshold, Upper" = "solid"))

    if (!is.na(thresholds[[lower_col]])) {
      plot <- plot + geom_hline(aes(yintercept = thresholds[[lower_col]], linetype = "NRV Threshold, Lower"), color = "black")
    }
    if (!is.na(thresholds[[upper_col]])) {
      plot <- plot + geom_hline(aes(yintercept = thresholds[[upper_col]], linetype = "NRV Threshold, Upper"), color = "black")
    }

    print(plot)
  })
}
