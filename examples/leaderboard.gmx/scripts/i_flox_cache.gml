/**
 * i_flox_cache_get() Map
 * Gets the cache map
 */
 
var cache = map_get(self._persistentData,"serviceCache");
if not i_flox_assert(map_exists(cache), "Cache has been deleted! This should never happen") then exit;
return cache;

