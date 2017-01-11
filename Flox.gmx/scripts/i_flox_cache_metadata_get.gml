/**
 * i_flox_cache_metadata_get(String path, String key, Any default) Any
 * Returns the value for the specified metadata for a given path 
 * If the metadata doesn't exist, it will return the default value
 */

var path = argument0;
var key = argument1;
var metaPath = path + "-" + key;
var def = argument2;

if not i_flox_assert(is_string(path) and path != "", "Cache path '"+string(path)+"' is invalid") then exit;
if not i_flox_assert(is_string(key) and key != "", "Cache metadata key '"+string(key)+"' is invalid") then exit;

var cache = i_flox_cache();
if map_has(cache,metaPath) {
    return map_get(cache,metaPath);
}
else return def;
