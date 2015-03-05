/**
 * i_flox_on_entity_save_error(Map request, Map response, Real httpStatus, Map cachedResponse)
 * Called whenever a save entity request fails
 */

var request    = argument0;
var error      = argument1;
var httpStatus = argument2;

// Remove the copy of the entity
// Because we did not use map_set_map we must
// manually remove this entity
var entityCopy = map_get(request,"entity");
flox_entity_free(entityCopy);

// Callback
var onError = map_get(request,"entityOnError");
var context = map_get(request,"entityContext");
i_flox_callback(context,onError,error,httpStatus);
