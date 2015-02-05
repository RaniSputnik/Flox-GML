/**
 * i_flox_on_queued_request_complete(Map request, Map response, Real httpStatus)
 * Called when a request made with i_flox_request_queued completes.
 * Flags the service queue for processing so that it moves onto the
 * the next request that was scheduled.
 */

self._serviceProcessingQueue = false;
i_flox_service_queue_dequeue();
self._serviceQueueShouldProcess = true;
