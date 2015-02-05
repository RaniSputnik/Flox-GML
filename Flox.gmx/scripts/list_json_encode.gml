/**
 * list_json_encode(List list) String
 * Encodes a list to json
 */
 
var list = argument0;
// The only way to json encode a list is by wrapping it in a map
// (We could do this manually but we'd miss the nested data structures)
var helperMap = ds_map_create();
ds_map_add_list(helperMap,"default",list);
var json = json_encode(helperMap);
ds_map_delete(helperMap,"default");
ds_map_destroy(helperMap);
// Remove the map that the list is now nested inside of
var openListPos = string_pos("[",json);
var str = string_copy(json,openListPos,string_length(json));
var endChar = "";
do {
    str = string_delete(str,string_length(str),1);
    endChar = string_char_at(str,string_length(str))
}
until endChar != " " and endChar != "}";
// Return the result
return str;
