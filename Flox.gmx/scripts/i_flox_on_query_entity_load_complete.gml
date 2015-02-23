/**
 * i_flox_on_query_entity_load_complete(Map request, Map body, Real httpStatus)
 * Called for each entity a query loads successfully.
 */

var request    = argument0;
var body       = argument1;
var httpStatus = argument2;
var query      = map_get(request,"query");
var position   = map_get(request,"position");

// Parse the entity from the result
var entityType = map_get(request,"entityType");
var entityId   = map_get(request,"entityId");
var entity = i_flox_entity_from_map(entityType,entityId,body);

// Add the entity to the query results
i_flox_query_add_entity(query,position,entity);
