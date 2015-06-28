/// flox_entity_destroy(entity,onComplete,onError)
//
//  Destroys a given entity, first by freeing it and then
//  removing it from the server. This function is asynchronous 
//  and will execute either onComplete or onError when it is finished.
 
var entity = argument0;
var onComplete = argument1;
var onError = argument2;

if not i_flox_assert(flox_entity_exists(entity),
    "Can not destroy entity '"+string(entity)+"', entity does not exist") then return false;
    
var entityType = map_get(entity,fx_type);
var entityId = map_get(entity,fx_id);
flox_entity_free(entity);
return flox_entity_destroy_type(entityType,entityId,onComplete,onError);
