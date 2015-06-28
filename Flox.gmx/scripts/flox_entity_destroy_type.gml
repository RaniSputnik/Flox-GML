/// flox_entity_destroy_type(type,id,onComplete,onError)
// 
//  Destroys a given entity by type and id, removing it from
//  the server. This function is asynchronous and will execute
//  either onComplete or onError when it is finished.
 
var entityType = string(argument0);
var entityId   = string(argument1);
var onComplete = argument2;
var onError    = argument3;
var context    = id;

// Check id is not blank
if not i_flox_assert(entityType != "",
    "Can not destroy entity, entity type is blank") then return false;
if not i_flox_assert(entityId != "",
    "Can not destroy entity, entity id is blank") then return false;

with i_flox_assert_initialized() {  
    // Make the request
    var path = i_flox_entity_url(entityType,entityId);
    var req = i_flox_request(http_method_delete,path,noone,
        i_flox_on_entity_destroy_complete,i_flox_on_entity_destroy_error);
    // Set the extra request parameters we will will need
    // in the callback scripts
    map_set(req,"entityType",entityType);
    map_set(req,"entityId",entityId);
    map_set(req,"entityOnComplete",onComplete);
    map_set(req,"entityOnError",onError);
    map_set(req,"entityContext",context);
    
    return true;
}
return false;
