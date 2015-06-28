/**
 * i_flox_request_create(String method, String path, Map data,
 *      Script(Map request, Map response, Number status) onComplete,
 *      Script(Map request, String error, Number status, Map cachedResponse) onError) Map
 * Creates a request object. Callbacks are optional, pass noone if
 * they are not needed. 
 */
 
var method     = argument0;
var path       = argument1;
var data       = argument2;
var onComplete = argument3;
var onError    = argument4;

// might change before we're in the event handler!
var auth = i_flox_authentication_get();
// Build the request object
var request = map_create("queued-request: method="+method+", path="+path);
map_set(request,"method",method);
map_set(request,"path",path);
// Add the data if it exists
// If the data is pre-encoded, it will be a string
if is_string(data) {
    i_flox_debug_message(fx_log_verbose,data);
    map_set(request,"data",data);
}
// Otherwise we have a map of data to encode
else if map_exists(data) {
    i_flox_debug_message(fx_log_warn,"Request created with map, this will soon be removed");
    var dataCopy = map_deep_copy(data);
    map_meta_set_name(dataCopy,"queued-requests-data-copy");
    map_set_map(request,"data",dataCopy);
}
// Add the authentication (if it exists)
if map_exists(auth) {
    var authCopy = map_deep_copy(auth);
    map_meta_set_name(authCopy,"queued-requests-auth-copy");
    map_set_map(request,"authentication",authCopy);
}
else map_set(request,"authentication",noone);
// Add the on complete callback
if script_exists(onComplete) {
    map_set(request,"onComplete",onComplete);
}
// Add the on error callback
if script_exists(onError) {
    map_set(request,"onError",onError);   
}

return request;
