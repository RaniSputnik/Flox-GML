/// flox_entity_refresh(entity,onComplete,onError)
//
//  Updates the properties of an entity with the copy from
//  the server.

var entity     = argument0;
var onComplete = argument1;
var onError    = argument2;
var context    = id;

if not i_flox_assert(flox_entity_exists(entity),
    "Can not refresh entity, entity does not exist") then return false;

with i_flox_assert_initialized() {
    var entityType = map_get(entity,fx_type);
    var entityId = map_get(entity,fx_id);
    var path = i_flox_entity_url(entityType,entityId);
    
    // Build the request
    var req = i_flox_request(http_method_get,path,noone,
        i_flox_on_entity_refresh_complete,i_flox_on_entity_refresh_error);
    map_set(req,"entityType",entityType);
    map_set(req,"entityId",entityId);
    map_set(req,"entityOnComplete",onComplete);
    map_set(req,"entityOnError",onError);
    map_set(req,"entityContext",context);
    
    return true;
}
return false;
