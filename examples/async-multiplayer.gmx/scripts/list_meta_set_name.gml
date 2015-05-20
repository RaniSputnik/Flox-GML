/**
 * list_meta_set_name(List list, String name)
 * Sets the display name for a given list, useful for debugging
 */

var list = argument0;
var key = string(argument0)+"-name";
var name = argument1;
global.__listInfo[? key] = name;
