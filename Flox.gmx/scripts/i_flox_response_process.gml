/**
 * i_flox_response_process(Map response)
 * Process a new repsonse from the server
 */

var response = argument0;
var requestId = map_get(response,"id");
// Sometimes we can receive multiple responses for a single id,
// if this isn't the final response ignore it
if not map_has(response,"http_status") then exit;
// TODO need to investigate what causes this
// I suspect it is a forced network login like, for instance 
// when you are using free WiFi and you are forced to login every half hour or so
// The response may end up being HTML rather than the JSON response we are
// expecting

// If this request id exists in the service requests then this http response
// matches one of the flox requests that were dispatched
if map_has(self._serviceRequests,requestId) {
    // Determine event details
    var status = map_get(response,"status");
    var httpStatus = map_get(response,"http_status");
    var headers = map_get(response,"response_headers");
    var body = map_get(response,"result");
    // Print out debug messages if necessary
    flox_debug_message("Processing response");
    flox_debug_message("Response",json_encode(response));

    // Find the basic request info
    var requestInfo = map_get(self._serviceRequests,requestId);
    var method      = map_get(requestInfo,"method");
    var path        = map_get(requestInfo,"path");
    var data        = map_default(requestInfo,"data",noone);
    var cache       = map_default(requestInfo,"cachedResult",noone);
    var onComplete  = map_default(requestInfo,"onComplete",noone);
    var onError     = map_default(requestInfo,"onError",noone);

    // If we couldn't contact the server for any odd/unknown reasons
    if status < 0 and not map_exists(headers) {
        flox_debug_message("Flox server unreachable");
        if script_exists(onError)
            then script_execute(onError,requestInfo,"Flox server unreachable",http_status_unknown,cache);
    }
    // Even if the request succeeded we now must check whether or not the servers
    // Internal request was successful (We post to www.flox.cc/api with our request
    // and the server performs the request internally)
    else {
        var response = json_decode(body);
        // Respond to parse errors
        if not map_exists(response) {
            flox_debug_message("Invalid response from Flox server");
            var error = "Invalid response from Flox server: "+body;
            if script_exists(onError)
                then script_execute(onError,requestInfo,error,httpStatus,cache);
        }
        // The response was parsed successfully and should now be processed
        else {
            // If the request was successful
            if flox_http_status_is_success(httpStatus) {
                // If it is a get request then we cache and return
                if method == http_method_get {
                    // If the status was NOT_MODIFIED then we can simply
                    // return the existing cached copy
                    if httpStatus == http_status_not_modified {
                        map_destroy(response);
                        var cacheCopy = map_deep_copy(cache);
                        response = cacheCopy;
                    }
                    // Otherwise if the entity has been modified then we need
                    // to update our cached copy 
                    else i_flox_cache_response(path,headers,response);
                }
                // A PUT request signifies that an entity has been added to the
                // server. We take the more accurated createdAt / updatedAt times
                // and apply them to our object to cache
                else if method == http_method_put {
                    var dataCopy = map_deep_copy(data);
                    if map_has(response,fx_created_at) and map_has(response,fx_updated_at) {
                        var createdAt = map_get(response,fx_created_at);
                        var updatedAt = map_get(response,fx_updated_at);
                        map_set(dataCopy,fx_created_at,createdAt);
                        map_set(dataCopy,fx_updated_at,updatedAt);
                    }
                    i_flox_cache_response(path,headers,dataCopy);
                }
                // If it is a delete request, delete the local copy too :)
                else if method == http_method_delete {
                    i_flox_cache_remove(path);
                }
                // We made it! SUCCESS! Now call the onComplete script
                if script_exists(onComplete)
                    then script_execute(onComplete,requestInfo,response,httpStatus);
            }
            // Otherwise the Flox response was an error status
            else {
                var error = "Unknown";
                // Try and determine the error message
                if map_exists(response) and map_has(response,"message")
                    then error = map_get(response,"message");
                flox_debug_message("Request was not successful, error = "+error);
                // Call the onError script
                if script_exists(onError)
                    then script_execute(onError,requestInfo,error,httpStatus,cache);
            }  
            map_destroy(response);
        }
    }
    map_destroy(requestInfo);
    map_delete(self._serviceRequests,requestId);
}