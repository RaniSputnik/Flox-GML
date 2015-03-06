/**
 * flox_query_offset(Real offset)
 * Offsets the results by a given amount, can be used to
 * paginate. ie. you fetch the first 50 results, then
 * offset by 50 and fetch the next batch of results.
 */

// Use string(round(offset)) to force ints when json_encoding
var offset = string(round(argument0));
with flox_assert_initialized {
    if not i_flox_assert_query_building() return false;
    map_set(self._query,"offset",offset);
}

return true;

