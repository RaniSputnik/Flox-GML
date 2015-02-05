/**
 * i_flox_encode_map_for_uri(Map data) String
 * Encodes a map into url parameters. The leading ? is not included
 * to allow for maximum flexibility.
 * eg. "foo=bar&key=value&secondkey=val2"
 */

// TODO encode for URI does NOT handle nested properties

var data = argument0;
var str = "";
var addAnd = false;
var key = ds_map_find_first(data);
var n = ds_map_size(data);
repeat n {
    if addAnd then str += "&"
    else addAnd = true;
    var value = ds_map_find_value(data,key);
    str += key + "=" + string(value);
    key = ds_map_find_next(data,key);
}
return str;
