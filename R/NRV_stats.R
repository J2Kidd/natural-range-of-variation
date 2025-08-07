#' NRV Stats Calculation
#'
#' Calculations that will populate the NRV stats table
#'
#' @param x Data frame with water quality data for each site
#'
#' @return calculations for the NRV stats table
#' @importFrom stats median quantile sd na.omit shapiro.test
#' @importFrom dplyr tibble
#' @importFrom expss count_if gt lt
#' @export
NRV_stats <- function(x) {

  n <- length(na.omit(x$ResultRaw))
  pnd <- round((length(na.omit(x$ResultRaw)[x$RDC == "BDL"]) / n) * 100, 0)
  meanx <- signif(mean(x$ResultCalc, na.rm = TRUE))
  sdx <- ifelse(n == 1, "NC", as.character(signif(stats::sd(x$ResultCalc, na.rm = TRUE))))
  minx <- min_val(x)
  maxx <- max_val(x)
  medx <- stats::median(x$ResultCalc, na.rm = TRUE)
  quanx <- signif(stats::quantile(x$ResultCalc, c(0.25, 0.50, 0.75, 0.90), na.rm = TRUE))
  S_W <- perform_sw_test(x$ResultCalc)
  S_WLog <- perform_sw_test(x$ResultCalcLog)

  # TIF method selection based on Shapiro-Wilk test results
  TIF_method <- ifelse(pnd >= 50,
                         NA,
                         ifelse(S_W >= 0.05 || S_WLog < 0.05,
                                "TIF",
                                ifelse(S_W < 0.05 && S_WLog >= 0.05,
                                       "TIFLog",
                                       NA)))

  # M2M method selection based on Shapiro-Wilk test results
  M2M_method <- ifelse(pnd >= 50,
                         NA,
                         ifelse(S_W >= 0.05 || S_WLog < 0.05,
                                "M2M",
                                ifelse(S_W < 0.05 && S_WLog >= 0.05,
                                       "M2MLog",
                                       NA)))

  # TIF threshold calculations
  TIF_lower <- ifelse(TIF_method == "TIF", TIF_Low(x$ResultCalc),
                      ifelse(TIF_method == "TIFLog", TIF_LowLog(x$ResultCalcLog),
                             NA))

  TIF_upper <- ifelse(TIF_method == "TIF", TIF_High(x$ResultCalc),
                      ifelse(TIF_method == "TIFLog", TIF_HighLog(x$ResultCalcLog),
                             NA))

  # M2M threshold calculations
  M2M_lower <- ifelse(M2M_method == "M2M", M2M_Low(x$ResultCalc),
                      ifelse(M2M_method == "M2MLog", M2M_LowLog(x$ResultCalcLog),
                             NA))

  M2M_upper <- ifelse(M2M_method == "M2M", M2M_High(x$ResultCalc),
                         ifelse(M2M_method == "M2MLog", M2M_HighLog(x$ResultCalcLog),
                                NA))

  # Determine if log transformation was used (same for both methods)
  logTransformed <- ifelse(pnd >= 50, NA,
                           ifelse(TIF_method == "TIFLog", "YES", "NO"))

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
                logTransformed = logTransformed,
                TIF_lowerThreshold = TIF_lower,
                TIF_upperThreshold = TIF_upper,
                M2MAD_lowerThreshold = M2M_lower,
                M2MAD_upperThreshold = M2M_upper)
}

