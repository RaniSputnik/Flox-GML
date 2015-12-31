/**
 * i_flox_cache_get(String path, String eTag) Map
 * Returns the cached body at the given path.
 * If eTag is given, it must match the cached objects eTag
 * otherwise the function will return noone;
 */

var path     = argument0;
var eTag     = argument1;
var cache = i_flox_cache();

if not i_flox_assert(is_string(path),"Cache path '"+string(path)+"' is invalid!") return noone;
if not i_flox_assert(is_string(eTag),"Cache eTag '"+string(eTag)+"' is invalid!") return noone;

i_flox_debug_message(fx_log_verbose,"Fetching from cache path="+path+", eTag="+eTag);
// Cached object or noone (but don't write the 'noone' into the
var cachedObject = map_default(cache,path,noone,false);
if map_exists(cachedObject) {
    var cachedETag = i_flox_cache_metadata_get(path,"eTag",fx_null);
    if (eTag == fx_null or eTag == cachedETag) {
        return cachedObject;
    }
}
return noone;
