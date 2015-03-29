/**
 * flox_query_limit(Real limit)
 * Sets the maximum number of results that can be returned
 * by the query, default is 50.
 */

// Use string(round(limit)) to force ints when json_encoding
var limit = string(round(argument0));
with flox_assert_initialized {
    if not i_flox_assert_query_building() then return false;
    map_set(self._query,"limit",limit);
}

return true;