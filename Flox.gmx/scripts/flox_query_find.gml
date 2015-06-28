/// flox_query_find(onComplete,onError)
//
//  Use this script after building a query to find the results.
//  This script is asychronous and will execute either
//  onComplete or onError when it is finished.

var onComplete = argument0;
var onError    = argument1;
var context    = id;

// Ensure that the callbacks provided are valid
if not i_flox_assert(script_exists(onComplete),
    "'"+string(onComplete)+"' is not a valid script") then exit;
if not i_flox_assert(script_exists(onError),
    "'"+string(onError)+"' is not a valid script") then exit;

// Perform the request
with i_flox_assert_initialized() {
    if not i_flox_assert_query_building() return false;
    // Get the properties of the query
    var entityType = map_get(_query,"type");
    var path = "entities"+"/"+string(entityType);
    // Make the request
    var offset = map_get(self._query,"offset");
    var limit = map_get(self._query,"limit");
    var queryJSON = '{"offset":'+string(offset)+',"limit":'+string(limit);
    if map_has(self._query,"where") {
        queryJSON += ',"where":"'+map_get(self._query,"where")+'"';
    }
    if map_has(self._query,"orderBy") {
        queryJSON += ',"orderBy":"'+map_get(self._query,"orderBy")+'"';
    }
    queryJSON += '}';
    i_flox_debug_message(fx_log_silly,"Constructed query: "+queryJSON);
    var req = i_flox_request(http_method_post,path,queryJSON,
        i_flox_on_query_complete,i_flox_on_query_error);
    map_set(self._query,"onComplete",onComplete);
    map_set(self._query,"onError",onError);
    map_set(self._query,"context",context);
    // the query has not been aborted yet
    map_set(self._query,"abort",false);
    // We use ds_map_add rather than ds_map_add_map to ensure that the query
    // map is not destroyed when the request is cleaned up. One the query is
    // completed it will still be needed to load the entities
    map_set(req,"query",self._query);
    self._query = noone;
}

return true;
