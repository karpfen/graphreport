test_that ("graph_sizes", {
    from <- c (1, 1, 4, 6)
    to <- c (2, 3, 5, 7)
    graph <- data.frame (from, to)
    graph_err <- data.frame (from, from)

    testthat::expect_error (get_graph_sizes (n),
                            "graph must be of type data.frame.")
    testthat::expect_error (get_graph_sizes (graph_err),
        "graph must contain columns from and to.")

    sizes <- get_graph_sizes (graph)
    testthat::expect_type (sizes, "list")
    testthat::expect_equal (sizes$Size, c (3, 2))
    testthat::expect_equal (sizes$Frequency, c (1, 2))
})

test_that ("node_degrees", {
    from <- c (1, 1, 4, 6)
    to <- c (2, 3, 5, 7)
    graph <- data.frame (from, to)
    graph_err <- data.frame (from, from)

    testthat::expect_error (get_node_degrees (n),
                            "graph must be of type data.frame.")
    testthat::expect_error (get_node_degrees (graph_err),
        "graph must contain columns from and to.")

    degrees <- get_node_degrees (graph)
    testthat::expect_type (degrees, "list")
    testthat::expect_equal (sum (degrees$frequency == 1), 6)
    testthat::expect_equal (sum (degrees$frequency == 2), 1)
})

test_that ("edge_weight", {
    from <- c (1, 1, 4, 6)
    to <- c (2, 3, 5, 7)
    weight <- c (1, 1, 2, 3)
    graph <- data.frame (from, to, weight)
    graph_err <- data.frame (from, to)

    testthat::expect_error (get_edge_weight_summary (n),
                            "graph must be of type data.frame.")
    testthat::expect_error (get_edge_weight_summary (graph_err),
        "graph must contain columns from, to and weight.")

    weight <- get_edge_weight_summary (graph, n = 2)
    testthat::expect_type (weight, "list")
    testthat::expect_equal (weight$Value, c (1.5, 3))
})

test_that ("unique_vertices", {
    from <- c (1, 1, 4, 6)
    to <- c (2, 3, 5, 7)
    weight <- c (1, 1, 2, 3)
    graph <- data.frame (from, to, weight)
    graph_err <- data.frame (from, from)

    testthat::expect_error (get_num_unique_vertices (n),
                            "graph must be of type data.frame.")
    testthat::expect_error (get_num_unique_vertices (graph_err),
        "graph must contain columns from and to.")

    n_vert <- get_num_unique_vertices (graph)
    testthat::expect_type (n_vert, "integer")
})
