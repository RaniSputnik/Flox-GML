/**
 * i_flox_cache_get(String path) Map
 * Returns the cached body at the given path
 */

var path     = argument0;
var cache = i_flox_cache();
// Return the data or noone (but don't write the 'noone' into the
// cache map
return map_default(cache,path,noone,false);

