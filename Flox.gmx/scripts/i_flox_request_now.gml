/**
 * i_flox_request_now(String method, String path, Map data,
 *      Script(Map request, Map response, Number status) onComplete,
 *      Script(Map request, String error, Number status, Map cachedResponse) onError) Map
 * Makes a request with callbacks for success and error, if there are requests
 * in the request queue, then they will be completed first (to ensure data integrity).
 * Returns the request map for storing data.
 */

var method     = argument0;
var path       = argument1;
var data       = argument2;
var onComplete = argument3;
var onError    = argument4;

// Start the service queue processing
if i_flox_service_queue_process() {
    // If the service queue is currently processing, then add this request to
    // the list of requests that will be performed when the queue is finished processing
    var request = i_flox_request_create(method,path,data,onComplete,onError);  
    list_add_map(self._serviceRequestsAwaitingQueueCompletion,request);
    return request;
}
// Othewise, we can make this request right away
else {
    var auth = i_flox_authentication_get();
    return i_flox_request_with_auth(method,path,data,auth,noone,onComplete,onError);
}
