/**
 * flox_on_queued_request_error(Map request, String error, Real httpStatus, Map cachedResult)
 * Called when a request made with i_flox_request_queued fails.
 * Stops the request queue processing.
 */

var request      = argument0;
var error        = argument1;
var httpStatus   = argument2;
var cachedResult = argument3;

self._serviceProcessingQueue = false;

if flox_http_status_is_transient_error(httpStatus) {
    // Server did not answer or is not available! we stop queue processing.
    flox_log_info("Flox server not reachable (device probably offline). "+
        "HttpStatus: "+string(httpStatus));   
    // Then we notifiy the service queue is finished processing
    i_flox_service_queue_finished(httpStatus,error);
}
else {
    // Server answered, but there was a logic error -> no retry
    flox_log_warning("Flox service queue request failed: "+string(error)+", HttpStatus: "+string(httpStatus));
    i_flox_service_queue_dequeue();
    self._serviceQueueShouldProcess = true;
}
