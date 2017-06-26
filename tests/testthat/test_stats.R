test_that ("graph_sizes", {
    n <- 50
    from <- as.integer (runif (min = 0, max = 100, n))
    to <- as.integer (runif (min = 0, max = 100, n))
    graph <- data.frame (from, to)
    sizes <- get_graph_sizes (graph)
    testthat::expect_type (sizes, "list")
    testthat::expect_error (get_graph_sizes (n),
                            "graph must be of type data.frame.")
    graph_err <- data.frame (from, from)
    testthat::expect_error (get_graph_sizes (graph_err),
        "graph must contain columns from and to.")
})

test_that ("node_degrees", {
    n <- 50
    from <- as.integer (runif (min = 0, max = 100, n))
    to <- as.integer (runif (min = 0, max = 100, n))
    graph <- data.frame (from, to)
    degrees <- get_node_degrees (graph)
    testthat::expect_type (degrees, "list")
    testthat::expect_error (get_node_degrees (n),
                            "graph must be of type data.frame.")
    graph_err <- data.frame (from, from)
    testthat::expect_error (get_node_degrees (graph_err),
        "graph must contain columns from and to.")
})

test_that ("edge_weight", {
    n <- 50
    from <- as.integer (runif (min = 0, max = 100, n))
    to <- as.integer (runif (min = 0, max = 100, n))
    weight <- runif (n)
    graph <- data.frame (from, to, weight)
    weight <- get_edge_weight_summary (graph)
    testthat::expect_type (weight, "list")
    testthat::expect_error (get_edge_weight_summary (n),
                            "graph must be of type data.frame.")
    graph_err <- data.frame (from, to)
    testthat::expect_error (get_edge_weight_summary (graph_err),
        "graph must contain columns from, to and weight.")
})

test_that ("unique_vertices", {
    n <- 50
    from <- as.integer (runif (min = 0, max = 100, n))
    to <- as.integer (runif (min = 0, max = 100, n))
    graph <- data.frame (from, to)
    n_vert <- get_num_unique_vertices (graph)
    testthat::expect_type (n_vert, "integer")
    testthat::expect_error (get_num_unique_vertices (n),
                            "graph must be of type data.frame.")
    graph_err <- data.frame (from, from)
    testthat::expect_error (get_num_unique_vertices (graph_err),
        "graph must contain columns from and to.")
})
