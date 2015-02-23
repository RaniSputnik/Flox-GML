/**
 * flox_init(String gameID, String gameKey, String version)
 * Initializes flox with the given gameId, key and version
 * Your gameId and Key are given to you when you create your game in
 * the flox control panel www.flox.cc/panel
 * The version can be any string you like, analytics can be segregated
 * by version so this is just for your own organisation
 */

// Initialize our custom data structure handling 
// (because otherwise debugging is a mish)
map_meta_init();
list_meta_init();
 
var gameID = argument0;
var gameKey = argument1;
var gameVersion = argument2;

// Verify argument types and validity
if not flox_assert(is_string(gameID) and gameID != '', "Game ID must be a valid string")
or not flox_assert(is_string(gameKey) and gameKey != '', "Game Key must be a valid string")
or not flox_assert(is_string(gameVersion), "Game version must be a valid string eg. '0.4.10'")
    return false;

// Get the flox instance and ensure that it is not already initialzed
with flox_get() {
    if not flox_assert(not self._initialized,"Flox is already initialized!") then return false;

    self._initialized = true;

    self.gameID = gameID;
    self.gameKey = gameKey;
    self.gameVersion = gameVersion;
    
    // Initialize persistent data and rest service
    i_flox_persistent_load();
    self._callbacks = list_create("[Flox] Callbacks");
    self._serviceRequests = map_create("[Flox] Service Requests");
    self._serviceBasePath = "www.flox.cc/api/";
    self._serviceRequestsAwaitingQueueCompletion = list_create("[Flox] Requests awaiting queue completion");
    
    // Log in a new guest player if there wasn't a player in the cache
    var player = flox_player_get();
    var auth = i_flox_authentication_get();
    if not flox_entity_exists(player) or not map_exists(auth) {
        i_flox_player_login(fx_guest,fx_null,fx_null,noone,noone,id);
    } 
    
    // Start a new session
    var installationID = map_get(self._persistentData,"installationID");
    var previousSession = map_get(self._persistentData,"session");
    i_flox_session_start(self.gameID, self.gameVersion, installationID, self.reportAnalytics, previousSession);
    if map_exists(previousSession) then i_flox_session_destroy(previousSession);
}

flox_log_info('Game Started');

return true;
