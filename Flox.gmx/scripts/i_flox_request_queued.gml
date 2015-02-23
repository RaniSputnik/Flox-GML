/**
 * i_flox_request_queued(String method, String path, Map data)
 * Defers a queue based on availability. If the server is currently
 * reachable, the queued request will be performed right away. However
 * if the server can not be reached then the request will be saved for 
 * later. Queued requests are persisted across sessions, so if you make
 * a request and it fails then the game is closed. When the game is
 * reopened the request will be attempted again. Order is guaranteed.
 */

var method = argument0;
var path   = argument1;
var data   = argument2;
var queue = map_get(self._persistentData,"serviceQueue");   

if method == http_method_put {
    // To allow developers to use Flox offline, we're optimistic here:
    // even though the operation might fail, we're saving the object in the cache.
    var dataCopy = map_deep_copy(data);
    i_flox_cache_add(path,dataCopy,noone);
    // if PUT is called repeatedly for the same resource (path),
    // we only need to keep the newest one.
    for (var i = ds_list_size(queue)-1; i > 0; i--) {
        var request = ds_list_find_value(queue,i);
        var requestPath = map_get(request,"path");
        if requestPath == path {
            ds_list_delete(queue,i);
            i -= 1;
        }
    }
}
// Add the request to the queue   
var request = i_flox_request_create(method,path,data,noone,noone);
i_flox_service_queue_enqueue(request);

return request;
