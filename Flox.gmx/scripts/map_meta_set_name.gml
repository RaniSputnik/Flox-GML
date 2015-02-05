/**
 * map_meta_set_name(Map map, String name)
 * Sets the display name for a given map, useful for debugging
 */

var map = argument0;
var key = string(argument0)+"-name";
var name = argument1;
global.__mapInfo[? key] = name;
