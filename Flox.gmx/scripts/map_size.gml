/**
 * map_size(Map map) Number
 * Returns the size of the map
 */

var map = argument0;
if not i_flox_assert(map_exists(map),"Can not calculate map size, map '"+string(map)+"' does not exist") return 0;
return ds_map_size(map);
