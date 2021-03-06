% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/graph_stats.R
\name{get_node_degrees}
\alias{get_node_degrees}
\title{Get degrees of all nodes in the graph}
\usage{
get_node_degrees(graph)
}
\arguments{
\item{graph}{\code{data.frame} containing the graph. must have columns from
and to, so each row defines an edge.}
}
\value{
\code{data.frame} the ID and frequency of every node in the graph.
}
\description{
Get degrees of all nodes in the graph
}
\examples{
\dontrun{
n <- 50
from <- as.integer (runif (min = 0, max = 100, n))
to <- as.integer (runif (min = 0, max = 100, n))
graph <- data.frame (from, to)

get_node_degrees (graph = graph)
}
}
