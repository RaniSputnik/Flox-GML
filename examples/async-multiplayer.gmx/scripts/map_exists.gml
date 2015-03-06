/**
 * map_exists(Map map) Boolean
 * Returns whether or not a map with the given id exists
 */

if argument0 == 0 or argument0 == global.__mapInfo then return false; // Catch for ZERO MAP

// TODO in debug mode check deleted maps list

return ds_exists(argument0,ds_type_map);

