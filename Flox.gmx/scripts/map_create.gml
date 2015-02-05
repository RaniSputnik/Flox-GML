/**
 * map_create(String name = "") Map
 * Creates a map, optionally you can provide a display name to 
 * help remember what map this is
 */

var mapid = ds_map_create();
if argument_count > 0 {
    map_meta_set_name(mapid,argument[0]);
}
return mapid;
