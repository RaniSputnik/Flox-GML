/**
 * flox_entity_set(Entity entity, String property, Real/String value)
 * Sets a property on the given entity to the specified value
 */

var entity = argument0;
var prop   = argument1;
if not flox_assert(flox_entity_exists(entity),"Can not set entity property '"+prop+"', entity does not exist") return false;
map_set(entity,prop,argument2);
