/**
 * map_meta_init()
 * Intializes the meta info for the map data structures
 * The meta info keeps info to assist debugging
 */

global.__mapInfo = ds_map_create();
map_meta_set_name(global.__mapInfo,"<MapMeta>");