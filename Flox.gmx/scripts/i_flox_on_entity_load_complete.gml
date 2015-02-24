/**
 * i_flox_on_entity_load_complete(Map request, Map body, Real httpStatus)
 * Called when an entity is loaded successfully from the server.
 */

var request    = argument0;
var body       = argument1;
var httpStatus = argument2;

// Parse the entity from the result
var entityType = map_get(request,"entityType");
var entityId   = map_get(request,"entityId");
var entity = i_flox_entity_from_map(entityType,entityId,body);

// Callback
var onComplete = map_get(request,"entityOnComplete");
var context = map_get(request,"entityContext");
i_flox_callback(context,onComplete,entity);
