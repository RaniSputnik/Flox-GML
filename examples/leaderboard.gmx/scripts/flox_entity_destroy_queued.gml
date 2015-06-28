/// flox_entity_destroy_queued(entity)
//
//  Removes an entity to the server at the next available moment.
 
var entity = real(argument0);
if not i_flox_assert(flox_entity_exists(entity),
    "Trying to destroy an entity that does not exist") return false;
 
with i_flox_assert_initialized() {
    var entityId = map_get(entity,fx_id);
    var entityType = map_get(entity,fx_type);
    var path = i_flox_entity_url(entityType,entityId);
    flox_entity_free(entity);
    i_flox_request_queued(http_method_delete, path, noone);
    
    return true;
}
return false;
