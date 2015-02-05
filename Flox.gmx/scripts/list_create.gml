/**
 * list_create(String name = "")
 * Creates a list, optionally you can provide a display name to 
 * help remember what map this is
 */

var list = ds_list_create();
if argument_count > 0 {
    list_meta_set_name(list,argument[0]);
}
return list;