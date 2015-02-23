/**
 * i_flox_cache_add(String path, Map data, Map metadata)
 * Adds an entry to the cache with the given data and
 * metadata.
 */

var path     = argument0;
var data     = argument1;
var metadata = argument2;
var cache = i_flox_cache();

// Remove the existing cache, freeing any data structures
i_flox_cache_remove(path);
// Add the new cached object
map_set_map(cache,path,data);
map_meta_set_name(data,"[Cache] path="+path);
// Set the metadata too
if map_exists(metadata) {
    var key = ds_map_find_first(metadata);
    repeat ds_map_size(metadata) {
        var metakey = path + "-" + key;
        map_set(cache,metakey,map_get(metadata,key));
        key = ds_map_find_next(metadata,key);
    }
}
// We've modified the cache so mark it to be saved on the next step
i_flox_persistent_invalidate();
