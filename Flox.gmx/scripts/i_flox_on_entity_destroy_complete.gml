/**
 * i_flox_on_entity_destroy_complete(Map request, Map response, Real httpStatus)
 * Called when an entity is destroyed successfully
 */
 
var request    = argument0;
var response   = argument1;
var httpStatus = argument2;

// Callback
var onComplete = map_get(request,"entityOnComplete");
var context    = map_get(request,"entityContext");
i_flox_callback(context,onComplete);
