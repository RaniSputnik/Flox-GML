/// flox_query_limit(limit)
//
//  Sets the maximum number of results that can be returned
//  by the query, default is 50.

var limit = round(argument0);
with i_flox_assert_initialized() {
    if os_type == os_windows and limit > 8 {
        i_flox_debug_message(fx_log_warn,"WARNING: You're query limit has been capped to '8' on Windows. "+
            "Read more about this issue here https://bitbucket.org/RaniSputnik/flox-gml/wiki/Limit%20of%208%20for%20Queries%20on%20Windows");
    }
    if not i_flox_assert_query_building() then return false;
    map_set(self._query,"limit",limit);
}

return true;
