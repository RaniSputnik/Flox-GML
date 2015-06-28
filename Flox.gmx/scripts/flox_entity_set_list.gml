/// flox_entity_set_list(entity,prop,list)
//
// Sets a property on the given entity to the specified list


var entity = argument0;
var prop   = string(argument1);
var list   = argument2;

if not i_flox_assert(flox_entity_exists(entity),
    "Can not set entity property '"+prop+"', entity does not exist") return false;
if not i_flox_assert(list_exists(list),
    "Can not set entity property '"+prop+"' to list '"+string(list)+"', list does not exist") return false;

map_set_list(entity,prop,list);
return true;
