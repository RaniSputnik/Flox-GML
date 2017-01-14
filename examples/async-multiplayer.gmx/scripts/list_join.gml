/// list_join(List list, String delim) String
/// Formats a list by joining the values with the given delimeter

var list = argument0;
var delim = string(argument1);

i_flox_assert(list_exists(list),"Can not join list '"+string(list)+"', list does not exist");

var str = "";
var n = ds_list_size(list);
for (var i = 0; i < n; i++) {
    var val = ds_list_find_value(list,i);
    var strVal = string(val);
    if (i > 0) str += delim;
    str += strVal;
}
return str;

