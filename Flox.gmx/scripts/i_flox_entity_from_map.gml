/**
 * i_flox_entity_from_map(String type, String id, Map map) Entity
 * Creates an entity of the given type with the given id
 * and applies the maps properties to it.
 */

var entityType = argument0;
var entityId   = argument1;
var map        = argument2;

// If no map was supplied then return noone
if not flox_assert(map_exists(map),"Can not create entity of type '"+entityType+"' and id '"+entityId+"' from map, no map provided")
    return noone;
// Create a new entity by copying the map
var entity = map_deep_copy(map);
map_meta_set_name(entity,"[Entity] "+entityType);
map_set(entity,flox_type,entityType);
map_set(entity,flox_id,entityId);
// Ensure that the created entity has all the required properties
if not flox_assert(flox_entity_exists(entity),"Can not create entity of type '"+entityType+"' and id '"+entityId+"' from map, map missing properties") {
    map_destroy(entity);
    return noone;
}
// Return the newly created entity
return entity;
