/**
 * i_flox_callback(Object context, Script script, Any arguments...)
 * Queues a callback request for Flox
 */

var context = argument[0];
var script  = argument[1];

if instance_exists(context) and script >= 0 {
    var callback = map_create("[Flox] callback");
    map_set(callback,"context",context);
    map_set(callback,"script",script);
    map_set(callback,"argCount",argument_count-2);
    for (var i = 2; i < argument_count; i++) {
        map_set(callback,"arg"+string(i-2),argument[i]);
    }   
    ds_list_add(self._callbacks,callback);
}