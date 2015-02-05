/**
 * list_add_list(List list, List toAdd)
 * Adds a list to the given list.
 * Marks the added list for json encoding.
 */

ds_list_add(argument0,argument1);
ds_list_mark_as_list(argument0,ds_list_size(argument0)-1);
