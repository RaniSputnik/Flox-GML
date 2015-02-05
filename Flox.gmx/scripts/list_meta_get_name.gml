/**
 * list_meta_get_name(List list) String
 * Gets the display name of a given list
 */

var list = argument0;
var key = string(list)+"-name";
if ds_map_exists(global.__listInfo,key) {
    return global.__listInfo[? key];
}
else return "<Unknown>";
