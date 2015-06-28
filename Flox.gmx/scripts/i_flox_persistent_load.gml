/**
 * i_flox_persistent_load() Map
 * Loads the persisted flox data ie. the queued requests the
 * response cache, the current player, session and auth details
 * Returns the persistent data in a map.
 */

i_flox_debug_message(fx_log_verbose,"Loading persistent data"); 
// Create a map that the data will be stored in
var contents = noone;
// Read the contents of the persistent file
if not self.preventPersistentDataLoad {
    var path = i_flox_persistent_filepath_get(self.gameID);
    if file_exists(path) {
        var map = ds_map_secure_load(path);
        if map_exists(map) and map_has(map,self.gameKey) {
            var str = map_get(map,self.gameKey);
            map_destroy(map);
            i_flox_debug_message(fx_log_silly,"Data",str);
            // Add the contents into the map
            contents = json_decode(str);
            if map_exists(contents) {
                map_meta_set_name(contents,"[Flox] Persistent Data");
                i_flox_debug_message(fx_log_verbose,"Loaded persistent data successfully");
            }
            else i_flox_debug_message(fx_log_warn,"Failed to parse persisted data!");
        }
        else i_flox_debug_message(fx_log_warn,"Failed to load persisted data! Malformed data file.");
    }
    else i_flox_debug_message(fx_log_warn,"No persistent data found, this is likely to be the first time this game has run");
}
else i_flox_debug_message(fx_log_warn,"Data will not be loaded, 'preventPersistentDataLoad' is enabled");
// Create an empty contents map if none was loaded
if not map_exists(contents) 
    then contents = map_create("[Flox] Persistent Data");

// Create the defaults if any are missing
map_default(contents,"installationID",flox_create_uid());   
map_default(contents,"authentication",noone);
map_default(contents,"currentPlayer",noone);
map_default(contents,"session",noone);
if not map_has(contents,"serviceQueue")
    then map_set_list(contents,"serviceQueue",list_create("[Flox] Service Queue"));
if not map_has(contents,"serviceCache") or not map_exists(map_get(contents,"serviceCache"))
    then map_set_map(contents,"serviceCache",map_create("[Flox] Service Cache"));

// Set the display names for the maps and lists now that they're loaded
var authentication = map_get(contents,"authentication");
if map_exists(authentication) then map_meta_set_name(authentication,"[Flox] Authentication");
var currentPlayer = map_get(contents,"currentPlayer");
if map_exists(currentPlayer) then map_meta_set_name(currentPlayer,"[Entity] .player");
var previousSession = map_get(contents,"session");
if map_exists(previousSession) {
    map_meta_set_name(previousSession,"[Flox] previousSession");
    list_meta_set_name(map_get(previousSession,"log"),"[Previous Session] log");
}
list_meta_set_name(map_get(contents,"serviceQueue"),"[Flox] Service Queue");
map_meta_set_name(map_get(contents,"serviceCache"),"[Flox] Service Cache");
// Set the display names for the cache
var serviceCache = map_get(contents,"serviceCache");
var path = ds_map_find_first(serviceCache);
repeat map_size(serviceCache) {
    if string_pos("eTag",path) < 1 {
        var cachedMap = map_get(serviceCache,path);
        map_meta_set_name(cachedMap,"[Cache] path="+path);
        if string_pos("leaderboards",path) > 0 {
            var leaderboardList = map_get(cachedMap,"default");
            if list_exists(leaderboardList) {
                list_meta_set_name(leaderboardList,'[Flox] Leaderboard');
                for (var i=0, n=list_size(leaderboardList); i<n; i++) {
                    var scoreData = ds_list_find_value(leaderboardList,i);
                    map_meta_set_name(scoreData,'[Flox] Score');
                }
            }
        }        
    }
    path = ds_map_find_next(serviceCache,path);
}

// Set the persistent data
self._persistentData = contents;
