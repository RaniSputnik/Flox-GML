/**
 * i_flox_entity_url(String type, String id) String
 * Returns the endpoint for a given entity.
 */
 
var entityType = string(argument0);
var entityId = string(argument1);
if entityType == "" then entityType = "<invalid>";
if entityId == "" then entityId = "<invalid>";

return "entities/"+entityType+"/"+entityId;
