/// flox_entity_exists(entity)
//
//  Returns whether or not the specified entity exists
 
var entity = argument0;

// TODO maybe we'll add checks in here for all
// required fields of an entities type too (including
// custom fields) or maybe that'll be a separate
// flox_entity_valid(entity) script
return
    map_exists(entity) and
    map_has(entity,fx_id) and
    map_has(entity,fx_type);
    

