/**
 * i_flox_service_queue_process() Boolean
 * Process the service queue.
 */

// If we aren't already processing the queue
if not self._serviceProcessingQueue {
    // Get the first element from the queue
    var queue = map_get(self._persistentData,"serviceQueue");
    // If there is an element in the request queue that requires processing, process it
    if ds_list_size(queue) > 0 {
        self._serviceProcessingQueue = true;
        var request = ds_list_find_value(queue,0);
        // Copy the request so that the queue doesn't become invalid
        // when the response is processed
        var requestCopy = map_deep_copy(request);
        map_set(requestCopy,"onComplete",i_flox_on_queued_request_complete);
        map_set(requestCopy,"onError",i_flox_on_queued_request_error);
        var req    = i_flox_request_perform(requestCopy);
        // Do not clean up the request queue here
        // We only want to do that once the request is successful
    }
    // Else dispatch that the service queue is complete
    else {
        self._serviceProcessingQueue = false;
        i_flox_service_queue_finished(http_status_ok,fx_null);
    }
}

return self._serviceProcessingQueue;
