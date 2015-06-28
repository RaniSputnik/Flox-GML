/**
 * map_default(Map map, String key, Any default, Boolean shouldWrite = true) Any
 * Returns the value with the given key from the given map
 * If the map does not contain the key, the default value is returned
 * If shouldWrite is true, the default value will be written to 
 * the map if the key is not present
 */

var map = argument[0];
var key = argument[1];
var def = argument[2];
var shouldWrite = true;
if argument_count > 3 then shouldWrite = argument[3] == true;
// Ensure the map exists
if not i_flox_assert(map_exists(map),"Can not use default value for key '"+string(key)+"' of map '"+string(map)+"', map does not exist")
    return false;
// If the map doesn't have the key then return/write the default
if not map_has(map,key) {
    if shouldWrite then map_set(map,key,def);
    return def;
}
// Otherwise return the existing value
else return ds_map_find_value(map,key);
