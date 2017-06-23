#' Generate graph report from a template
#'
#' @param graph \code{data.frame} containing the graph. must have columns from,
#' to and weight, so each row defines an edge.
#'
#' @param article_name file name of the article.
#'
#' @param n The desired number of quantiles for the edge weight section.
#'
#' @export
generate_graph_report <- function (graph, article_name = "graph-report", n = 10)
{
    fname <- paste0 (article_name, ".Rmd")
    rmarkdown::draft (file = fname, edit = FALSE,
                      template = "inst/rmarkdown/templates/graphreport")
    rmarkdown::render (paste0 (article_name, "/", fname), params = list ("graph" = graph, "n" = n))
}
