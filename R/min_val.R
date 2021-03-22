#' Calculate the maximum value
#'
#' @param x Water quality parameter
#' @return Maximum value of water quality parameter
#' @export
min_val <- function(x) {

  min.val <- min(x$ResultRaw)

  min.record <- subset(x, ResultRaw == min(ResultRaw))

  min.qual <- unique(min.record$RDC)

  min.final <- if(any(min.qual %in% 'BDL')) { paste0('<', min.val) } else {as.character(min.val)}

  return(min.final)

}
