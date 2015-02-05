/**
 * map_meta_get_name(Map map) String
 * Gets the display name of a given map
 */

var mapid = argument0;
var key = string(mapid)+"-name";
if ds_map_exists(global.__mapInfo,key) {
    return global.__mapInfo[? key];
}
else return "<Unknown>";
