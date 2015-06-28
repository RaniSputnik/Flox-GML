/**
 * i_flox_on_entity_destroy_error(Map request, Map response, Real httpStatus, Map cachedResponse)
 * Called whenever a destroy entity request fails.
 */

var request    = argument0;
var error      = argument1;
var httpStatus = argument2;
var cachedBody = argument3;

// Callback
var onError = map_get(request,"entityOnError");
var context = map_get(request,"entityContext");
i_flox_callback(context,onError,error,httpStatus);