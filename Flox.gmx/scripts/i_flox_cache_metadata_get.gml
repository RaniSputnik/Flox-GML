/**
 * i_flox_cache_metadata_get(String path, String key, Any default) Any
 * Returns the value for the specified metadata for a given path 
 * If the metadata doesn't exist, it will return the default value
 */

var path = string(argument0);
var key = string(argument1);
var metaPath = path + "-" + key;
var def = argument2;

var cache = i_flox_cache();
if map_has(cache,metaPath) {
    return map_get(cache,metaPath);
}
else return def;
