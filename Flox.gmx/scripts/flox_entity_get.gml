/// flox_entity_get(entity,prop)
//
//  Returns the value of a given entity property

var entity       = argument0;
var prop         = argument1;
// Assert the entity exists and has the property
if not i_flox_assert(flox_entity_exists(entity),"Can not get entity property '"+prop+"', entity does not exist")
or not i_flox_assert(map_has(entity,prop),"Can not get entity property '"+prop+"', property not found on entity")
    return undefined;
// Return the value of the property
return map_get(entity,argument1);
