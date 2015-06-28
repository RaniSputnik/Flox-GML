/// flox_query_where(constraints,params...)
//
//  Adds a where clause to the query.
//  Subsequent where clauses will override previous constraints.

var constraints = string(argument[0]);
var numPlaceholders = string_count("?",constraints);

// Check that the number of ?'s matches the number of arguments provided
if not i_flox_assert(numPlaceholders == argument_count-1,
    "'With' constraints invalid, number of placeholders does not match the number of arguments") then return false;

with i_flox_assert_initialized() {
    if not i_flox_assert_query_building() return false;
    // Add constraints
    var lastArgPos = 1;
    for (var i=1; i<argument_count; i++) {
        var curPos = string_pos("?",constraints);
        var curString = string_copy(constraints,lastArgPos,curPos-lastArgPos+1)
        // If we are using the 'IN' constraint, magically turn the
        // argument into a list so that the dev's don't gotta remember
        var inPos = string_pos("IN",curString);
        if inPos != 0 {
            if not i_flox_assert(list_exists(argument[i]),
                "'"+string(argument[i])+"' is not a valid list and can not be used for an IN constraint") return false;
            else argument[i] = i_flox_query_list_string(argument[i]);
        }
        constraints = string_replace(constraints,"?",argument[i]);
        lastArgPos = curPos;
    }
    map_set(_query,"where",constraints);
}

return true;
