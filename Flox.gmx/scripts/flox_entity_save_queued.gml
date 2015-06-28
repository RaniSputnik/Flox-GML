/// flox_entity_save_queued(entity)
//
//  Saves an entity to the server at the next available moment.
 
var entity = real(argument0);
if not i_flox_assert(flox_entity_exists(entity),
    "Trying to save an entity that does not exist") then return false;
 
with i_flox_assert_initialized() {
    var entityId = map_get(entity,fx_id);
    var entityType = map_get(entity,fx_type);
    // Find the REST endpoint
    var path = i_flox_entity_url(entityType,entityId);
    // Send the request
    var data = i_flox_entity_to_map(entity);
    i_flox_request_queued(http_method_put, path, data);
    map_destroy(data);
    
    return true;
}
return false;
