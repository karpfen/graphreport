#' Get graph component statistics
#'
#' @param graph \code{data.frame} containing the graph. must have columns from,
#' to and weight.
#'
#' @return \code{data.frame} containing the number and size of graph components.
#'
#' @export
get_graph_statistics <- function (graph)
{
    print ("hello")
    rcpp_graph_components (graph)
}
