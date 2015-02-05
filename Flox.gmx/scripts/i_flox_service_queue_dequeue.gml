/**
 * i_flox_service_queue_dequeue()
 * Removes the first item from the service queue
 */

var queue = map_get(self._persistentData,"serviceQueue");
var requestCopy = ds_list_find_value(queue,0);
map_destroy(requestCopy);
ds_list_delete(queue,0);
// Invalidate the persistent data so it is updated
i_flox_persistent_invalidate();
