/**
 * i_flox_cache_get_metadata(String path, String field)

var path = i_flox_cache_get_metadata_path(argument0);
var meta = argument1;

var cache = i_flox_get_cache();
var metadata =  ds_map_find_value(cache,key);
return ds_map_find_value(metadata,meta);
