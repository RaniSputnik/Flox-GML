/**
 * i_flox_service_queue_enqueue(Map request)
 * Adds a new request to the service queue
 */

var request = argument0;
 
// Add the request to the queue
var queue = map_get(self._persistentData,"serviceQueue");
list_add_map(queue,request);
self._serviceQueueShouldProcess = true;
// Invalidate the persistent data so it is updated
i_flox_persistent_invalidate();
