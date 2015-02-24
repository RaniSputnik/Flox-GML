/**
 * i_flox_on_entity_save_complete(Map request, Map response, Real httpStatus)
 * Called when an entity is saved to the server successfully.
 */
 
var request    = argument0;
var body       = argument1;
var httpStatus = argument2;

var entity = map_get(request,"entity");
var onComplete = map_get(request,"entityOnComplete");
var context = map_get(request,"entityContext");
i_flox_callback(context,onComplete,entity);
