/**
 * flox_cache_clear()
 * Clears the Flox service cache (the server response cache)
 */

var cache = i_flox_cache();
map_destroy(cache);
cache = map_create("[Flox] Service Cache");
map_set_map(self._persistentData,"serviceCache",cache);
// We've modified the cache so it must now be saved
i_flox_persistent_invalidate();
