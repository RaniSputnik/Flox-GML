/**
 * map_set(Map map, String key, Any value) 
 * Sets the value for a key in the given map
 */

var map = argument0;
var key = argument1;
var val = argument2;
// Ensure the map exists
if not i_flox_assert(map_exists(map),"Can not set key '"+string(key)+"' of map '"+string(map)+"', map does not exist")
    return false;
// If the key already exists, delete it 
if ds_map_exists(map,key) then ds_map_delete(map,key);
// Add the new value
ds_map_add(map,key,val);
