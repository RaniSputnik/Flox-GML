/**
 * list_meta_delete(List list)
 * Deletes all meta information for a given list
 */

var list = argument0;
var key = string(list) + "-name";
ds_map_delete(global.__listInfo,key);
