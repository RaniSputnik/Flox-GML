/**
 * i_flox_cache_remove(String path)
 * Remove the given path from the cache
 */
 
var path = argument0;
var cache = i_flox_cache();
map_delete(cache,path);
var key = ds_map_find_first(cache);
var n = map_size(cache);
repeat n {
    if string_pos(path+"-",key) > 0 then map_delete(cache,key); 
    key = ds_map_find_next(cache,key);
}
// We've modified the cache so mark that it needs to be saved
i_flox_persistent_invalidate();
