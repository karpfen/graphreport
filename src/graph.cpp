#include <Rcpp.h>
#include <vector>
#include <map>

typedef std::string vertex_id_t;

struct vertex_t
{
    private:
        std::set <vertex_id_t> in, out;

    public:
        void add_neighbour_in (vertex_id_t osm_id) { in.insert (osm_id); }
        void add_neighbour_out (vertex_id_t osm_id) { out.insert (osm_id); }
        int get_degree_in () { return in.size (); }
        int get_degree_out () { return out.size (); }
        std::set <vertex_id_t> get_all_neighbours ()
        {
            std::set <vertex_id_t> all_neighbours = in;
            all_neighbours.insert (out.begin (), out.end ());
            return all_neighbours;
        }
};

typedef std::map <vertex_id_t, vertex_t> vertex_map;

void graph_from_df (Rcpp::DataFrame gr, vertex_map &vm)
{
    Rcpp::StringVector from = gr ["from"];
    Rcpp::StringVector to = gr ["to"];
    Rcpp::NumericVector weight = gr ["weight"];

    for (int i = 0; i < to.length (); i ++)
    {
        vertex_id_t from_id = std::string (from [i]);
        vertex_id_t to_id = std::string (to [i]);

        if (vm.find (from_id) == vm.end ())
        {
            vertex_t from_v = vertex_t ();
            vm.insert (std::make_pair(from_id, from_v));
        }
        vertex_t from_vtx = vm.at (from_id);
        from_vtx.add_neighbour_out (to_id);
        vm [from_id] = from_vtx;

        if (vm.find (to_id) == vm.end ())
        {
            vertex_t toV = vertex_t ();
            vm.insert (std::make_pair(to_id, toV));
        }
        vertex_t to_vtx = vm.at (to_id);
        to_vtx.add_neighbour_in (from_id);
        vm [to_id] = to_vtx;
    }
}

std::map <int, int> get_largest_graph_component (vertex_map &v, std::map <vertex_id_t, int> &com,
        int &largest_id)
{
    int component_number = 0;
    // initialize components map
    for (auto it = v.begin (); it != v.end (); ++ it)
        com.insert (std::make_pair (it -> first, -1));

    for (auto it = v.begin (); it != v.end (); ++ it)
    {
        std::set <int> comps;
        vertex_id_t vtxId = it -> first;
        vertex_t vtx = it -> second;
        std::set <vertex_id_t> neighbors = vtx.get_all_neighbours ();
        comps.insert (com.at (vtxId));
        for (auto n:neighbors)
            comps.insert (com.at (n));
        int largest_comp_num = *comps.rbegin ();
        if (largest_comp_num == -1)
            largest_comp_num = component_number ++;
        com.at (vtxId) = largest_comp_num;
        for (auto n:neighbors)
            com.at (n) = largest_comp_num;
        for (auto c = com.begin (); c != com.end (); ++ c)
        {
            vertex_id_t cOsm = c -> first;
            int cNum = c -> second;
            if (comps.find (cNum) != comps.end () && cNum != -1)
                com.at (cOsm) = largest_comp_num;
        }
    }

    std::set <int> unique_components;
    for (auto c:com)
        unique_components.insert (c.second);

    int largest_component_value = -1;
    std::map <int, int> component_size;
    for (auto uc:unique_components)
    {
        int com_size = 0;
        for (auto c:com)
        {
            if (c.second == uc)
                com_size ++;
        }
        if (com_size > largest_component_value)
        {
            largest_component_value = com_size;
            largest_id = uc;
        }
        component_size.insert (std::make_pair (uc, com_size));
    }
    return component_size;
}

//' rcpp_graph_components
//'
//' Calculates the number and size of graph components
//'
//' @param graph graph to be analysed
//' @return \code{Rcpp::DataFrame} containing the graph component IDs and sizes.
//'
//' @noRd
// [[Rcpp::export]]
Rcpp::DataFrame rcpp_graph_components (Rcpp::DataFrame graph)
{
    Rcpp::Rcout << "hello rcpp" << std::endl;
    vertex_map vertices;
    std::map <vertex_id_t, int> components;
    int largest_component;

    graph_from_df (graph, vertices);
    get_largest_graph_component (vertices, components, largest_component);

    std::vector <vertex_id_t> ids;
    ids.reserve (components.size ());
    std::vector <int> sizes;
    sizes.reserve (components.size ());

    for (auto kv : components)
    {
        ids.push_back (kv.first);
        sizes.push_back (kv.second);
    }

    Rcpp::DataFrame component_stats = Rcpp::DataFrame::create (
            Rcpp::Named ("id") = ids,
            Rcpp::Named ("size") = sizes);

    return component_stats;
}