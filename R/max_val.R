#' Calculate the maximum value
#'
#' @param x Water quality parameter
#'
#' @return Maximum value of water quality parameter
#' @export
max_val <- function(x) {

  max.val <- max(x$ResultRaw)

  max.record <- subset(x, ResultRaw == max(ResultRaw))

  max.qual <- unique(max.record$RDC)

  max.final <- if(any(max.qual %in% 'DET')) { as.character(max.val) } else { paste0('<', max.val) }

  return(max.final)

}
