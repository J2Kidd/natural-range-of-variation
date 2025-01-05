#' NRV Stats Calculation
#'
#' Calculations that will populate the NRV stats table
#'
#' @param x Data frame with water quality data for each site
#' @param data_type Data type is set as reference or impacted by the user in the NRV function. Default is reference.
#'
#' @return calculations for the NRV stats table
#' @importFrom stats median quantile sd IQR na.omit shapiro.test
#' @importFrom dplyr tibble
#' @importFrom expss count_if gt lt
#' @export
NRV_stats <- function(x, data_type = "reference") {

  n <- length(na.omit(x$ResultRaw))
  pnd <- round((length(na.omit(x$ResultRaw)[x$RDC == "BDL"]) / n) * 100, 0)
  meanx <- signif(mean(x$ResultCalc, na.rm = TRUE))
  sdx <- ifelse(n == 1, "NC", as.character(signif(stats::sd(x$ResultCalc, na.rm = TRUE))))
  minx <- min_val(x)
  maxx <- max_val(x)
  medx <- stats::median(x$ResultCalc, na.rm = TRUE)
  quanx <- signif(stats::quantile(x$ResultCalc, c(0.25, 0.50, 0.75, 0.90), na.rm = TRUE))
  IQRx <- (stats::IQR(x$ResultCalc, na.rm = TRUE)) * 1.5
  S_W <- perform_sw_test(x$ResultCalc)
  S_WLog <- perform_sw_test(x$ResultCalcLog)

  # Decision criteria for NRV_method selection adapted based on data_type
  if (data_type == "reference") {
    NRV_method <- ifelse(pnd < 25,
                         ifelse(S_W >= 0.05 || S_WLog < 0.05, "TIF", ifelse(S_W < 0.05 && S_WLog >= 0.05, "TIFLog", NA)),
                         ifelse(pnd >= 25 && pnd < 50,
                                ifelse(S_W >= 0.05 || S_WLog < 0.05, "M2M", ifelse(S_W < 0.05 && S_WLog >= 0.05, "M2MLog", NA)),
                                NA))
  } else if (data_type == "impacted") {
    NRV_method <- ifelse(pnd < 50,
                         ifelse(S_W >= 0.05 || S_WLog < 0.05, "M2M", ifelse(S_W < 0.05 && S_WLog >= 0.05, "M2MLog", NA)),
                         NA)
  }

  lower <- ifelse(NRV_method == "TIF", TIF_Low(x$ResultCalc),
                  ifelse(NRV_method == "M2M", M2M_Low(x$ResultCalc),
                         ifelse(NRV_method == "TIFLog", TIF_LowLog(x$ResultCalcLog),
                                ifelse(NRV_method == "M2MLog", M2M_LowLog(x$ResultCalcLog), NA))))

  upper <- ifelse(NRV_method == "TIF", TIF_High(x$ResultCalc),
                  ifelse(NRV_method == "M2M", M2M_High(x$ResultCalc),
                         ifelse(NRV_method == "TIFLog", TIF_HighLog(x$ResultCalcLog),
                                ifelse(NRV_method == "M2MLog", M2M_HighLog(x$ResultCalcLog), NA))))

  dplyr::tibble(n = n,
                percentNonDetect = pnd,
                MEAN = meanx,
                SD = sdx,
                MIN = minx,
                MAX = maxx,
                MED = medx,
                P25 = quanx[1],
                P50 = quanx[2],
                P75 = quanx[3],
                P90 = quanx[4],
                `S-W` = S_W,
                `S-W Log` = S_WLog,
                NRVMethod = NRV_method,
                lowerThreshold = lower,
                upperThreshold = upper)
}

