#' Get number and sizes of graph components
#'
#' @param graph \code{data.frame} containing the graph. must have columns from,
#' to and weight, so each row defines an edge.
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
#' get_graph_sizes (graph = graph)
#' }
get_graph_sizes <- function (graph)
{
    rcpp_graph_components (graph)
}

#' Get degrees of all nodes in the graph
#'
#' @param graph \code{data.frame} containing the graph. must have columns from,
#' to and weight, so each row defines an edge.
#'
#' @return \code{data.frame} the ID and frequency of every node in the graph.
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
#' get_node_degrees (graph = graph)
#' }
get_node_degrees <- function (graph)
{
    uq_all <- c (graph$from, graph$to) %>% unique
    degrees <- data.frame (uq_all)
    names (degrees) <- "id"
    degrees$frequency <- 0

    for (i in seq_along (uq_all))
    {
        id <- uq_all [i]
        deg <- dim (graph [graph$from == id | graph$to == id, ]) [1]
        degrees [i, "frequency"] <- deg
    }
    degrees
}

#' Get summary of edge weights
#'
#' @param graph \code{data.frame} containing the graph. must have columns from,
#' to and weight, so each row defines an edge.
#'
#' @param n The desired number of quantiles.
#'
#' @return \code{data.frame} containing the graph's edge weights divided into a
#' given number of quantiles.
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
#' get_edge_weight_summary (graph = graph, n = 5)
#' }
get_edge_weight_summary <- function (graph, n = 10)
{
    quants <- (1:n) / n
    qq <- quantile (graph$weight, probs = quants)
    quantiles <- data.frame (names (qq), qq)
    names (quantiles) <- c ("Quantile", "Value")
    rownames (quantiles) <- NULL
    quantiles
}

#' Get number of unique vertices
#'
#' @param graph \code{data.frame} containing the graph. must have columns from
#' and to, so each row defines an edge.
#'
#' @return The number of unique vertices in the graph.
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
#' get_num_unique_vertices (graph = graph)
#' }
get_num_unique_vertices <- function (graph)
{
    uq <- unique (c (graph$from, graph$to))
    length (uq)
}
