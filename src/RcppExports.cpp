// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// rcpp_graph_components
Rcpp::IntegerVector rcpp_graph_components(Rcpp::DataFrame graph);
RcppExport SEXP _graphreport_rcpp_graph_components(SEXP graphSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::DataFrame >::type graph(graphSEXP);
    rcpp_result_gen = Rcpp::wrap(rcpp_graph_components(graph));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_graphreport_rcpp_graph_components", (DL_FUNC) &_graphreport_rcpp_graph_components, 1},
    {NULL, NULL, 0}
};

RcppExport void R_init_graphreport(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
