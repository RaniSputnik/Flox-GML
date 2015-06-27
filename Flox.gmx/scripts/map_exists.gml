/**
 * map_exists(Map map) Boolean
 * Returns whether or not a map with the given id exists
 */

if is_string(argument0) then return false;
if argument0 == global.__mapInfo then return false; // Catch for meta info map

// TODO in debug mode check deleted maps list

return ds_exists(argument0,ds_type_map);
