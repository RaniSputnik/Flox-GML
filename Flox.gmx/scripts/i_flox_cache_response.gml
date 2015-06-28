/**
 * i_flox_cache_response(String path, Map headers, Map result)
 * Caches a response from the server
 */

var path    = argument0;
var headers = argument1;
var result  = argument2;

i_flox_debug_message(fx_log_verbose,"Caching response for path = "+path);
i_flox_debug_message(fx_log_silly,"Headers = "+json_encode(headers));

// Copy the result as the original will be discarded when the request is cleaned up
var resultCopy = map_deep_copy(result);
// Create the meta data
var metaData = map_create();
if map_has(headers,"ETag") {
    map_set(metaData,"eTag",map_get(headers,"ETag"));
}
i_flox_cache_add(path,resultCopy,metaData);
map_destroy(metaData);
