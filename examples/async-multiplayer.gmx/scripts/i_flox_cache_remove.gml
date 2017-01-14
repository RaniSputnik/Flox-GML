/**
 * i_flox_cache_remove(String path)
 * Remove the given path from the cache
 */
 
var path = argument0;
var cache = i_flox_cache();

if not i_flox_assert(is_string(path) and path != "", "Cache path '"+string(path)+"' is invalid") then exit;

// Remove the existing cache data
var existing = i_flox_cache_get(path,fx_null);
if map_exists(existing) map_destroy(existing);
map_delete(cache,path);
// Loop through and remove all the meta data
var key = ds_map_find_first(cache);
var remove_keys;
var remove_keys_n = 0;
repeat map_size(cache)
{
    if string_pos(path+"-",key) > 0 {
        remove_keys[remove_keys_n++] = key;
    }
    key = ds_map_find_next(cache,key);
}
for (var i = 0; i < remove_keys_n; i++)
{
    map_delete(cache,remove_keys[i]);
}
// We've modified the cache so mark that it needs to be saved
i_flox_persistent_invalidate();


