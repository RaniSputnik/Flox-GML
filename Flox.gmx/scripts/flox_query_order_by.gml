/// flox_query_order_by(property)
//
//  Orders the results by a given property.
//  Add either ASC or DESC to after the property to define
//  whether the results are order first-to-last or last-to-first.

var orderBy = string(argument0);
with i_flox_assert_initialized() {
    if not i_flox_assert_query_building() then return false;
    map_set(self._query,"orderBy",orderBy);
}

return true;
