/**
 * i_flox_on_query_complete(Map request, Map response, Real httpStatus)
 * Called when the initial query request has completed. When the
 * query request succeeds it includes a list of all the ids of the
 * entities that should be loaded. We use this to start a number of
 * other requests.
 */

var request    = argument0;
var response   = argument1;
var httpStatus = argument2;

var query = map_get(request,"query")
// The response is simply a list, but GameMaker will convert that
// to a map with a single 'default' key when is decodes the JSON
var results = map_get(response,"default");
var numResults = ds_list_size(results);
map_set(query,"numResults",numResults);
var entityType = map_get(query,"type");
 
// Three scenarios
// 1. There were no results - finish immediately
// 2. We were only loading ids - use the ids returned to finish immediately
// 3. We have some entities to load - wait until they all load then return
if numResults == 0 {
    map_set(query,"results",ds_list_create());
    i_flox_query_finish(query);
} 
else if map_get(query,"idsOnly") {
    // If we're only querying ids then we are done, no more loading please!
    var finalResults = ds_list_create();
    for (var i = 0; i < numResults; i++) {
        var result = ds_list_find_value(results,i);
        var entityId = ds_map_find_value(result,"id");
        ds_list_add(finalResults,entityId);
    }
    map_set(query,"results",finalResults); 
    i_flox_query_finish(query);
} 
else {
    // Don't set as a list to ensure that the list isn't destroyed when
    // we remove the query (the list is provided to the callback scripts)
    map_set(query,"results",ds_list_create());
    map_set(query,"numLoaded",0);
    
    // Loop over all the results and start a new request for each
    // to ensure that we load details of all the entities requested
    for (var i = 0; i < numResults; i++) {
        var result = ds_list_find_value(results,i);
        var entityId = ds_map_find_value(result,"id");
        var eTag = map_default(result,"eTag",fx_null);
        
        // Add in a placeholder so that all other entities get placed correctly
        var finalResults = map_get(query,"results");
        ds_list_add(finalResults,noone);
        
        // Attempt to load the entity from the cache
        var entityPath = i_flox_entity_url(entityType,entityId);
        var cachedEntity = i_flox_cache_get(entityPath,eTag);
        if map_exists(cachedEntity) {
            i_flox_debug_message(fx_log_silly,"Retrieved entity from cache");
            var entity = i_flox_entity_from_map(entityType,entityId,cachedEntity);
            i_flox_query_add_entity(query,i,entity);
        }
        // If it's not there then load it straight up
        else {
            i_flox_debug_message(fx_log_silly,"Requesting entity from server");
            var req = i_flox_request(http_method_get,entityPath,noone,
                i_flox_on_query_entity_load_complete,i_flox_on_query_error);
            map_set(req,"entityType",entityType);
            map_set(req,"entityId",entityId);
            // Provide the query and the position where the entity should be added
            map_set(req,"query",query);
            map_set(req,"position",i);
        }    
    }
}
