/// flox_entity_set_map(entity,prop,map)
//
//  Sets a property on the given entity to the specified map

var entity = argument0;
var prop   = string(argument1);
var map    = argument2;

if not i_flox_assert(flox_entity_exists(entity),
    "Can not set entity property '"+prop+"', entity does not exist") return false;
if not i_flox_assert(map_exists(map),
    "Can not set entity property '"+prop+"' to map '"+string(map)+"', map does not exist") return false;

map_set_map(entity,prop,map);
return true;
