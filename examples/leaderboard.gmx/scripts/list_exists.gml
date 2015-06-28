/**
 * map_exists(Map map) Boolean
 * Returns whether or not a map with the given id exists
 */

if is_string(argument0) then return false;
if argument0 == 0 then return false; // Catch for ZERO LIST

// TODO in debug mode check deleted maps list

return ds_exists(argument0,ds_type_list);
