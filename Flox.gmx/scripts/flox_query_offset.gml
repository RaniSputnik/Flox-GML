/// flox_query_offset(offset)
//
//  Offsets the results by a given amount, can be used to
//  paginate. ie. you fetch the first 50 results, then
//  offset by 50 and fetch the next batch of results.

var offset = round(argument0);
with i_flox_assert_initialized() {
    if not i_flox_assert_query_building() return false;
    map_set(self._query,"offset",offset);
}

return true;
