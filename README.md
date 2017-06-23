<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis-ci.org/karpfen/graphreport.svg?branch=master)](https://travis-ci.org/karpfen/graphreport)

graphreport
===========

R package for generating reports about graphs.

------------------------------------------------------------------------

Install
-------

``` r
devtools::install_github ('karpfen/graphreport')
```

Usage
-----

This example shows how to get some basic information about a graph.

``` r
n <- 50
from <- as.integer (runif (min = 0, max = 100, n))
to <- as.integer (runif (min = 0, max = 100, n))
weight <- runif (n)

graph <- data.frame (from, to, weight)
sizes <- get_graph_sizes (graph)
length (sizes) # print the number of graphs
sizes # print the size of every graph

degrees <- get_node_degrees (graph)
summary (degrees)

get_edge_weight_summary (graph, 5)
```

Code of Conduct
---------------

Please note that this project is released with a [Contributor Code of Conduct](https://github.com/osm-router/osmprob/blob/master/CONDUCT.md). By participating in this project you agree to abide by its terms.
