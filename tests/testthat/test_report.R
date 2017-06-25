test_that ("graph_report", {
    n <- 50
    from <- as.integer (runif (min = 0, max = 100, n))
    to <- as.integer (runif (min = 0, max = 100, n))
    weight <- runif (n)
    graph <- data.frame (from, to, weight)
    testthat::expect_error (generate_graph_report (n),
                            "graph must be of type data.frame.")
    graph_err <- data.frame (from, to)
    testthat::expect_error (generate_graph_report (graph_err),
        "graph must contain columns from, to and weight.")
})
