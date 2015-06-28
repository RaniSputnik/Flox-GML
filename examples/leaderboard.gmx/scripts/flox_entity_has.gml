/**
 * flox_entity_has(Entity entity, String prop) Boolean
 * Returns whether or not an entity has a given property
 */

var entity = argument0;
var prop   = argument1;

if not flox_assert(flox_entity_exists(entity),"Can not get entity property '"+prop+"', entity does not exist") return false;
return map_has(entity,prop);