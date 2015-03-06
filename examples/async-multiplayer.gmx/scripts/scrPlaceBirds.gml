// scrPlaceBirds(list,object_index)

var turns = argument0;
var obj   = argument1;

var n = ds_list_size(turns);
for (var i = 0; i < n; i++) {
    var str = ds_list_find_value(turns,i);
    var breakIndex = string_pos(",",str);
    var xx = real(string_copy(str,1,breakIndex-1));
    var yy = real(string_copy(str,breakIndex+1,string_length(str)-breakIndex));
    instance_create(xx,yy,obj);
}