/**
 * map_meta_delete(Map map)
 * Deletes all meta information for a given map
 */

var map = argument0;
var key = string(map) + "-name";
ds_map_delete(global.__mapInfo,key);
