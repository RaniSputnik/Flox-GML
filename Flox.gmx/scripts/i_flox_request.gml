// flox_service_request(method,path,data,callbackContext,scrComplete,scrError)

var method     = argument0;
var path       = argument1;
var data       = argument2;
var onComplete = argument3;
var onError    = argument4;

var request = i_flox_request_create(method,path,data,onComplete,onError);
// If the service queue is processing, then add the request
// to the list of requests that will be performed when the queue is 
// finished processing
if i_flox_service_queue_process() {
    list_add_map(self._serviceRequestsAwaitingQueueCompletion,request);
}
// Otherwise we can perform the request right away
else {
    i_flox_request_perform(request);
}
return request;
