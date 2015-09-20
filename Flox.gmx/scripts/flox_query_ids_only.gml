/// flox_query_ids_only()
//
//  Usually a query will callback with a list of all the entities
//  that are returned by the query, however this can take a while
//  if you are querying a lot of entities. If you query ids_only
//  then the list will instead contain entity ids, no extra loading
//  will be performed, allowing you to be smarter about how you load
//  those entities.

with i_flox_assert_initialized() {
    if not i_flox_assert_query_building() then return false;
    map_set(self._query,"idsOnly",true);
}
return true;
