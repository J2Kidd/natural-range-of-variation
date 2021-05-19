#' NRV Stats Calculation
#'
#' Calculations that will population the NRV stats table
#'
#' @param x Data frame with water quality data for each site
#'
#' @return
#' @import stats
#' @importFrom dplyr tibble
#' @importFrom expss count_if gt lt
#' @export
NRV_stats <- function(x) {

  n <- length(na.omit(x$ResultRaw))
  pnd <- round((length(na.omit(x$ResultRaw)[x$RDC == "BDL"]) / n) * 100, 1)
  ndr <- ifelse(pnd == 0,
                "--",
                ifelse(min(x$ResultRaw[x$RDC == "BDL"]) == max(x$ResultRaw[x$RDC == "BDL"]),
                       paste0("<", min(x$ResultRaw[x$RDC == "BDL"])),
                       paste0("<", min(x$ResultRaw[x$RDC == "BDL"]), " - <",
                              max(x$ResultRaw[x$RDC == "BDL"]))))
  meanx <- signif(mean(x$ResultCalc, na.rm = TRUE), 3)
  sdx <- ifelse(n == 1, "NC", as.character(signif(stats::sd(x$ResultCalc, na.rm = TRUE), 3)))
  minx <- min_val(x)
  maxx <- max_val(x)
  medx <- stats::median(x$ResultCalc)
  quanx <- signif(stats::quantile(x$ResultCalc, c(0.25, 0.75, 0.98)), 3)
  Q1 <- round(stats::quantile(x$ResultCalc, 0.25), 1)
  Q3 <- round(stats::quantile(x$ResultCalc, 0.75), 1)
  IQRx <- (stats::IQR(x$ResultCalc))*1.5
  outlier <- expss::count_if(expss::gt(Q3+IQRx),x$ResultCalc) + expss::count_if(expss::lt(Q1-IQRx),x$ResultCalc)
  outNum <- ifelse(outlier > 0, outlier, 0)
  PON <- round(((outNum / n) * 100),1)
  NRV_method <- ifelse(PON <= 10 && pnd <= 77, "TIF", ifelse(PON <= 50 && pnd <= 50 , "M2M", NA))
  lower <- ifelse(NRV_method == "TIF", TIF_Low(x$ResultCalc), ifelse(NRV_method == "M2M" , M2M_Low(x$ResultCalc), NA))
  upper <- ifelse(NRV_method == "TIF", TIF_High(x$ResultCalc), ifelse(NRV_method == "M2M" , M2M_High(x$ResultCalc), NA))

  dplyr::tibble("n" = n,
         "percentNonDetect" = pnd,
         "nonDetectRange" = ndr,
         "outlierNumber" = outNum,
         "percentOutliers" = PON,
         "MEAN" = round(meanx, 4),
         "SD" = sdx,
         "MIN" = minx,
         "MAX" = maxx,
         "MED" = medx,
         "Q1" = quanx[1],
         "Q3" = quanx[2],
         "P98" = quanx[3],
         "NRVMethod" = NRV_method,
         "lowerThreshold" = lower,
         "upperThreshold" = upper)

}
