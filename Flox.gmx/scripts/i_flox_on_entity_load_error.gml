/**
 * i_flox_on_entity_load_error(Map request, String error, Real httpStatus, Map cachedBody)
 * Called when an entity fails to load.
 */

var request    = argument0;
var error      = argument1;
var httpStatus = argument2;
var cachedBody = argument3;

// Parse the entity from the cachedBody (if there is one)
var cachedEntity = noone;
if map_exists(cachedBody) {
    var entityType = map_get(request,"entityType");
    var entityId   = map_get(request,"entityId");
    cachedEntity   = i_flox_entity_from_map(entityType,entityId,cachedBody);
}

// Callback
var onError = map_get(request,"entityOnError");
var context = map_get(request,"entityContext");
i_flox_callback(context,onError,error,httpStatus,cachedEntity);