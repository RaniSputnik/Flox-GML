/**
 * i_flox_query_finish(Map query)
 * Called when a query has finished loading all the entities.
 */

var query = argument0;
if not map_get(query,"abort") {
    var onComplete = map_get(query,"onComplete");
    var context = map_get(query,"context");
    var results = map_get(query,"results");
    i_flox_callback(context,onComplete,results);
}
// Free up the query
map_destroy(query);
