/**
 * i_flox_service_queue_finished(Number httpStatus, String error)
 * Called when the service queue has finished processing
 */

var httpStatus = argument0;
var error      = argument1;

// Whether or not the service queue processed successfully
var proccessingWasSuccessful = 
    flox_http_status_is_success(httpStatus) or
    not flox_http_status_is_transient_error(httpStatus);
    
// Process/clear any requests that were waiting for the queue to be processed
while list_size(self._serviceRequestsAwaitingQueueCompletion) > 0 {
    var request = ds_list_find_value(self._serviceRequestsAwaitingQueueCompletion,0);
    // If the processing was successful then we should try to make the requests
    if proccessingWasSuccessful {
        // The map is about to be freed so we must take a copy instead
        var requestCopy = map_deep_copy(request);
        i_flox_request_perform(requestCopy);
    }
    // Otherwise fail the requests, no point in even trying :(
    else {
        var onError = map_get(request,"onError");
        var cachedResult = map_default(request,"cachedResult",noone,false);
        if script_exists(onError) then script_execute(onError,request,error,httpStatus,cachedResult);
    }
    // Make sure to delete the requests from the queue (we have processed them now)
    ds_list_delete(self._serviceRequestsAwaitingQueueCompletion,0);
    map_destroy(request);
}
