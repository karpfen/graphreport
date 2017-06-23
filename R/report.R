#' Get graph component statistics
#'
#' @param graph \code{data.frame} containing the graph. must have columns from,
#' to and weight.
#'
#' @return \code{vector} containing the sizes of all individual graph components
#' in descending order.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' n <- 50
#' from <- as.integer (runif (min = 0, max = 100, n))
#' to <- as.integer (runif (min = 0, max = 100, n))
#' weight <- runif (n)
#' graph <- data.frame (from, to, weight)
#' 
#' get_graph_statistics (graph = graph)
#' }
get_graph_statistics <- function (graph)
{
    rcpp_graph_components (graph)
}
