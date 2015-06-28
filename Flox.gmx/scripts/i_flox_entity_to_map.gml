/**
 * i_flox_entity_to_map(Entity entity) Map
 * Transforms an entity to a ds_map. Makes a copy of the
 * original entity map.
 */
 
var entity = argument0;
if not i_flox_assert(flox_entity_exists(entity),"Attempting to convert an entity to a map that does not exist") exit;
var map = map_deep_copy(entity);
map_meta_set_name(map,"entity-data");

// TODO read the entity description for 
// information on what to serialize and what type
// things are

// Delete all non-serialized fields
map_delete(map,fx_type);
// Parse all dates
var createdAt = map_get(map,fx_created_at);
var updatedAt = map_get(map,fx_updated_at);
map_set(map,fx_created_at,flox_date_encode(createdAt));
map_set(map,fx_updated_at,flox_date_encode(updatedAt));
return map;
