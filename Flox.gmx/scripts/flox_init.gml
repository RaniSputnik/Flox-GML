/// flox_init(gameID,gameKey,version)
// 
//  Initializes flox with the given gameId, key and version
//  Your game id and key are given to you when you create your game in
//  the flox control panel www.flox.cc/panel

// Initialize our custom data structure handling 
// (because otherwise debugging is a mish)
map_meta_init();
list_meta_init();
 
var gameID = argument0;
var gameKey = argument1;
var gameVersion = argument2;

// Verify argument types and validity
if not i_flox_assert(is_string(gameID) and gameID != '', "Game ID must be a valid string")
or not i_flox_assert(is_string(gameKey) and gameKey != '', "Game Key must be a valid string")
or not i_flox_assert(is_string(gameVersion), "Game version must be a valid string eg. '0.4.10'")
    return false;

// Get the flox instance and ensure that it is not already initialzed
with flox_get() {
    if not i_flox_assert(not self._initialized,"Flox is already initialized!") then return false;

    // Change the random seed so that we don't end up
    // using the same id each time.
    randomize();
    
    self._initialized = true;

    self.gameID = gameID;
    self.gameKey = gameKey;
    self.gameVersion = gameVersion;
    
    // Initialize persistent data and rest service
    i_flox_persistent_load();
    self._serviceRequests = map_create("[Flox] Service Requests");
    self._serviceBasePath = "www.flox.cc/api/";
    self._serviceRequestsAwaitingQueueCompletion = list_create("[Flox] Requests awaiting queue completion");
    // Prepare to send phoney responses if we detect any issues with a request
    self._fakeResponses = list_create("[Flox] Service Responses");
    // The fake id of the next request, uses negatives to avoid
    // conflicts with valid responses from the server
    // starts at -5 to avoid noone constant
    self._nextFakeResponseId = -5;
    
    // Log in a new guest player if there wasn't a player in the cache
    var player = flox_player_get();
    var auth = i_flox_authentication_get();
    if not flox_entity_exists(player) or not map_exists(auth) {
        self.firstRun = true;
        i_flox_player_login(fx_guest,fx_null,fx_null,noone,noone);
    } 
    
    // Start a new session
    var installationID = map_get(self._persistentData,"installationID");
    var previousSession = map_get(self._persistentData,"session");
    i_flox_session_start(self.gameID, self.gameVersion, installationID, self.reportAnalytics, previousSession);
    if map_exists(previousSession) then i_flox_session_destroy(previousSession);
}

flox_log_info('Game Started');

return true;
