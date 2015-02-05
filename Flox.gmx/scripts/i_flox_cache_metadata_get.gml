/**
 * i_flox_cache_get_metadata(String path, String key, Any default) Any
 * Returns the value for the specified metadata for a given path 
 * If the metadata doesn't exist, it will return the default value
 */

var key = argument[1];
var path = argument[0]
var metaPath = path + "-" + key;
var def;
if argument_count > 2 then def = argument[2];

var cache = i_flox_cache();
if map_has(cache,metaPath) {
    return map_get(metadata,metaPath);
}
else {
    flox_assert(def != undefined,"Can not get metadata, path '"+path+"' does not have metadata for key '"+key+"'");
    return def;
}