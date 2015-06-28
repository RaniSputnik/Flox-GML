/// flox_entity_load_type(type,id,onComplete,onError) 
//
//  Loads an entity from the server by it's type and id.
//  This function is asynchronous and will execute either
//  onComplete or onError once it is finished.

var entityType = string(argument0);
var entityId   = string(argument1);
var onComplete = argument2;
var onError    = argument3;
var context    = id;

// Check id is not blank
if not i_flox_assert(entityType != "",
    "Can not load entity, entity type is blank") then return false;
if not i_flox_assert(entityId != "",
    "Can not load entity, entity id is blank") then return false;

with i_flox_assert_initialized() {  
    // Make the load request
    var path = i_flox_entity_url(entityType,entityId);
    var req = i_flox_request(http_method_get,path,noone,
        i_flox_on_entity_load_complete,i_flox_on_entity_load_error);
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
