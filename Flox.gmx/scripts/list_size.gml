/**
 * list_size(DSList list) Number
 * Return the size of the list
 */
 
var list = argument0;
if not i_flox_assert(list_exists(list),"Can not calculate list size, list '"+string(list)+"' does not exist") return 0;
return ds_list_size(list);
