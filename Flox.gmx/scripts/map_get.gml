/**
 * map_get(Map map, String key) Any
 * returns the valie of a map with the given key
 */

var map = argument0;
var key = argument1;

// Ensure the map exists
if not i_flox_assert(map_exists(map),"Can not get key '"+string(key)+"' of map '"+string(map)+"', map does not exist")
or not i_flox_assert(ds_map_exists(map,key),"Can not get key '"+string(key)+"' of map, map doesn't contain that key")
    return false;
// Return the value for the specified key
return ds_map_find_value(map,key);
