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
#' @importFrom ggplot2 ggplot element_rect guide_legend aes geom_jitter position_jitter labs scale_x_date theme_classic scale_y_continuous theme guides scale_linetype_manual geom_hline
#' @importFrom scales date_format
#' @export

NRVTimeSeries <- function(dataDF, thresholdDF, paramName = "ALL", season = "Open-Water") {
  suppressWarnings({
    if (toupper(paramName) == "ALL") {
      uniqueParameters <- unique(dataDF$Parameter)
      for (param in uniqueParameters) {
        NRVTimeSeries_individual(dataDF, param, thresholdDF, season)  # Pass season to the individual function
      }
    } else {
      NRVTimeSeries_individual(dataDF, paramName, thresholdDF, season)  # Pass season to the individual function
    }
  })
}

NRVTimeSeries_individual <- function(dataDF, paramName, thresholdDF, season) {
  suppressWarnings({
    if (!(paramName %in% dataDF$Parameter) || !(paramName %in% thresholdDF$Parameter)) {
      stop("Parameter not found in one of the data frames!")
    }

    thresholds <- subset(thresholdDF, Parameter == paramName)
    plotData <- subset(dataDF, Parameter == paramName)

    plot <- ggplot(plotData, aes(x = Date, y = ResultCalc, color = Site)) +
      geom_jitter(position = position_jitter(width = 125, height = 0), size = 3) +
      labs(x = paste("Year (", season, " Season)", sep=""), y = paste(paramName, "mg/L"), color = "Site") +
      scale_x_date(date_breaks = "1 year", labels = date_format("%Y")) +
      theme_classic(base_size = 20) +
      scale_y_continuous(labels = function(x) format(x, scientific = FALSE), limits = c(0, NA)) +
      theme(panel.border = element_rect(linewidth = 2, fill = NA, color = "black")) +
      guides(color = guide_legend(title = NULL), linetype = guide_legend(title = NULL, override.aes = list(color = c("black", "black")))) +
      scale_linetype_manual(values = c("NRV Threshold, Lower" = "dashed", "NRV Threshold, Upper" = "solid"))

    if (!is.na(thresholds$lowerThreshold)) {
      plot <- plot + geom_hline(aes(yintercept = thresholds$lowerThreshold, linetype = "NRV Threshold, Lower"), color = "black")
    }

    if (!is.na(thresholds$upperThreshold)) {
      plot <- plot + geom_hline(aes(yintercept = thresholds$upperThreshold, linetype = "NRV Threshold, Upper"), color = "black")
    }

    print(plot)
  })
}
