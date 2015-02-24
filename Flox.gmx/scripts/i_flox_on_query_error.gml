/**
 * i_flox_on_query_error(Map request, String error, Real httpStatus, Map cachedResponse)
 * Called when one of the queries requests fails.
 */

var request      = argument0;
var error        = argument1;
var httpStatus   = argument2;
var cachedResult = argument3;
var query        = map_get(request,"query");

// If the query hasn't already aborted then abort and
// callback 
if not map_get(query,"abort") {
    map_set(query,"abort",true);
    var onError = map_get(query,"onError");
    var context = map_get(query,"context");
    i_flox_callback(context,onError,error,httpStatus);
}

// If the query failed while loading results
// Then note that another result completed and free the query
// If it is complete
if map_has(query,"numLoaded") {
    var numLoaded = map_get(query,"numLoaded") + 1;
    map_set(query,"numLoaded",numLoaded);
    var numResults = map_get(query,"numResults");
    if numLoaded == numResults {
        map_destroy(query);
    }
}
// The query failed before it found any results
// therefore it is finished and we can destroy it.
else map_destroy(query);
