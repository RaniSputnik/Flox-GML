/**
 * i_flox_on_entity_refresh_complete(Map request, Map response, Real httpStatus)
 * Called when an entity is refreshed successfully.
 */

var request    = argument0;
var response   = argument1;
var httpStatus = argument2;

// Get the entity from the response
var entityType = map_get(request,"entityType");
var entityId = map_get(request,"entityId");
var entity = i_flox_entity_from_map(entityType,entityId,response);

// Callback
var onComplete = map_get(request,"entityOnComplete");
var context = map_get(request,"entityContext");
i_flox_callback(context,onComplete,entity,httpStatus == http_status_not_modified);
