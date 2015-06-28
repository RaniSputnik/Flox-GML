/**
 * map_delete(Map map, String key) Boolean
 * Deletes a given key from the given map.
 * Returns whether or not the key to delete existed.
 */

var map = argument0;
var key = argument1;
if not i_flox_assert(map_exists(map),"Can not delete key '"+string(key)+"' from map '"+string(map) + "', map does not exist") 
    return false;

// If the map has the key we are trying to delete, delete it and return true
if map_has(map,key) {
    ds_map_delete(map,key);
    return true;
}
// Otherwise return false;
else return false;
