/**
 * map_has(Map map, String key) Boolean
 * Returns whether or not a map has a given key
 */

var map = argument0;
var key = argument1;
// Check the map exists
if not i_flox_assert(map_exists(map),"Can not check if map '"+string(map)+"' has key '"+string(key)+"', map does not exist")
    return false;
// Return the whether or not the key exists
return ds_map_exists(map,key);
