/**
 * i_flox_query_add_entity(Map query, Real position, Entity entity)
 * Adds an entity that was loaded into the query results.
 * The entity may have been loaded from the server or from
 * the cached data.
 */

var query    = argument0;
var position = argument1;
var entity   = argument2;

// Add the result to the list in the specified position
var results  = map_get(query,"results");
list_replace_map(results,position,entity);

// See if the number of entities matches the number required
var numLoaded = map_get(query,"numLoaded") + 1
map_set(query,"numLoaded",numLoaded);
var numResults = map_get(query,"numResults");
if (numLoaded == numResults) {
    i_flox_query_finish(query);
}
