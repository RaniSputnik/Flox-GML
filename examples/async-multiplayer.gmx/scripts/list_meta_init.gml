/**
 * list_meta_init()
 * Intializes the meta info for the list data structures
 * The meta info assists debugging
 */

global.__listInfo = ds_map_create();
map_meta_set_name(global.__listInfo,"<ListMeta>");

// If there is no zero list create one,
// this is a list that will never be destroyed
// (lists with id 0 don't count as existing)
if not ds_exists(0,ds_type_list) {
    var ZEROLIST = ds_list_create();
    list_meta_set_name(ZEROLIST,"<ZEROLIST>");
}