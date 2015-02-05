/**
 * map_copy(Map to, Map from)
 * Copies all properties from a given map to another map
 * without clearing the map that it will copy to
 * WARNING this function may clear nested list/map info
 */

var to = argument0;
var from  = argument1;

var key = ds_map_find_first(from);
repeat ds_map_size(from) {
    map_set(to,key,ds_map_find_value(from,key));
    key = ds_map_find_next(from,key);
}
