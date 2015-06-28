/// flox_entity_free(entity)
//
//  Frees the memory used by an entity without destroying it on the server
//  Should be used whenever you are done with an entity

var entity = argument0;
if not i_flox_assert(flox_entity_exists(entity),"Can not free entity '"+string(entity)+"', entity does not exist") return false; 
map_destroy(entity);
