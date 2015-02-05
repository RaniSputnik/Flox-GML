/**
 * list_meta_has_name(List list) Boolean
 * Returns whether or not a given list has been named
 */
 
var list = argument0;
var key = string(list)+"-name";
return ds_map_exists(global.__listInfo,key)
