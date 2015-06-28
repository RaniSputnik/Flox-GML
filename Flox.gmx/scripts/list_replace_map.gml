/**
 * list_replace_map(List list, Real position, Map map)
 * Replaces a value in the list with the given map.
 * Marks the list for json encoding.
 */

var list = argument0;
var pos  = argument1;
var map  = argument2;

if not i_flox_assert(list_exists(list),
    "Can not replace map in list, list '"+string(list)+"' does not exist") then return false;
if not i_flox_assert(map_exists(map),
    "Can not replace map in list, map '"+string(map)+"' does not exist") then return false;
if not i_flox_assert(pos < ds_list_size(list),
    "Can not replace at position '"+string(pos)+"' in list '"+string(list)+
    ", that position is not valid in list of length '"+string(ds_list_size(list))+"'") then return false;

ds_list_replace(list,pos,map);
ds_list_mark_as_map(list,pos);

return true;
