/// flox_entity_save(entity,onComplete,onError)
//
//  Saves an entity to the server. This function is asynchronous
//  and will execute either onComplete or onError when it is finished.
 
var entity = argument0;
var onComplete = argument1;
var onError = argument2;
var context = id;

if not i_flox_assert(flox_entity_exists(entity),
    "Can not save entity '"+string(entity)+"', entity does not exist") then return false;

with i_flox_assert_initialized() {
    var entityId = map_get(entity,fx_id);
    var entityType = map_get(entity,fx_type);
    var path = i_flox_entity_url(entityType,entityId);
    var data = i_flox_entity_to_map(entity);
    var req = i_flox_request(http_method_put, path, data,
        i_flox_on_entity_save_complete,i_flox_on_entity_save_error);
    map_destroy(data);
    
    // Copy the entity so that even if it is freed
    // we still will have an entity to call-back with
    var entityCopy = map_deep_copy(entity);
    map_meta_set_name(entityCopy,"[Entity] "+entityType);
    // Do not use map_set_map -> this will ensure the entity
    // is not removed when the request is freed.
    map_set(req,"entity",entityCopy);
    map_set(req,"entityOnComplete",onComplete);
    map_set(req,"entityOnError",onError);
    map_set(req,"entityContext",context);
    
    return true;
}
return false;
