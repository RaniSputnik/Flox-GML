/**
 * list_deep_copy(List list) DSList
 * Makes a deep copy (that is a copy that also duplicates nested
 * data structures) of the given list and returns the copy
 */

var list = argument0;
var helperMap = ds_map_create();
ds_map_add_list(helperMap,"key",list);
var newMap = map_deep_copy(helperMap);
var newList = ds_map_find_value(newMap,"key");
ds_map_delete(helperMap,"key");
ds_map_delete(newMap,"key");
ds_map_destroy(helperMap);
ds_map_destroy(newMap);
// Give the new list a name
if list_meta_has_name(list) {
    var listname = list_meta_get_name(list)
    list_meta_set_name(newList,listname+"-Copy");
}

return newList;
