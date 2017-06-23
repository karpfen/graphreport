#' Generate graph report from a template
#'
#' @param graph \code{data.frame} containing the graph. must have columns from,
#' to and weight, so each row defines an edge.
#'
#' @param article_name file name of the article.
#'
#' @param n The desired number of quantiles for the edge weight section.
#'
#' @param format One or multiple values indicating the desired output format of
#' the report. See \code{rmarkdown::render} for possible formats.
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
#' generate_graph_report (graph = graph, n = 5, format = c ("html_document",
#' "pdf_document"))
#' }
generate_graph_report <- function (graph, article_name = "graph-report", n = 10,
                                   format = "pdf_document")
{
    fname <- paste0 (article_name, ".Rmd")

    rmarkdown::draft (file = fname, edit = FALSE, package = "graphreport",
                      template = "graphreport")
    rmarkdown::render (paste0 (article_name, "/", fname),
                       params = list ("graph" = graph, "n" = n),
                       output_format = format)
}
