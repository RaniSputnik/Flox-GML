/**
 * list_replace_map(List list, Real position, Map map)
 * Replaces a value in the list with the given map.
 * Marks the list for json encoding.
 */

var list = argument0;
var pos  = argument1;
var map  = argument2;
ds_list_replace(list,pos,map);
ds_list_mark_as_map(list,pos);
