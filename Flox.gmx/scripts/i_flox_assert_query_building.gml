/**
 * i_flox_assert_query_building()
 * Assert to check that a query is currently being constructed/
 */
 
return i_flox_assert(map_exists(self._query),
    "Can not find query, no query exists");
