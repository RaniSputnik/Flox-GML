/**
 * i_flox_query_list_string(List list)
 * Converts a list to a string that can be used in a flox
 * 'WHERE * IN ?' constraint.
 */

var list = argument0;

var str = "[";
var n = ds_list_size(list);
for (var i = 0; i < n; i++) {
    var val = ds_list_find_value(list,i);
    var strVal = string(val);
    if is_string(val) strVal = '"'+val+'"';
    if (i > 0) str += ",";
    str += strVal;
}
str += "]";
str = string_replace_all(str,"[","\[");
str = string_replace_all(str,"]","\]");
str = string_replace_all(str,":","\:");
str = string_replace_all(str,",","\,");
str = string_replace_all(str,'"','\"');

return str;
