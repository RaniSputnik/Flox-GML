/**
 * map_destroy(Map map, String reason = "")
 * Destroys the specified map optionally you can specify
 * a reason (for debugging purposes)
 */

var map = argument[0];
var reason = "";
if argument_count > 1 then reason = argument[1];

if not i_flox_assert(map_exists(map),"Can not destroy map '"+string(map)+"', map does not exist")
    return false;

ds_map_destroy(map);
map_meta_delete(map);
