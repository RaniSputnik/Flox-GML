/**
 * i_flox_session_start(String gameID, String gameVersion, String installationID, 
 *                      Boolean reportAnalytics, Map lastSession)
 * Starts a new session and closes the previous one. This will send the analytics of 
 * both sessions to the server (including log entries of the last session). 
 */

var gameID = argument0;
var gameVersion = argument1;
var installationID = argument2;
var reportAnalytics = argument3;
var lastSession = argument4; 

var newSession = i_flox_session_create(lastSession);

if reportAnalytics {
    // Send some info about the device we are playing on
    var deviceInfo = map_create("analytics-device-info");
    map_set(deviceInfo,"resolution",i_flox_get_display_resolution());
    map_set(deviceInfo,"os",i_flox_get_os());
    
    // Create the basic analytics data
    var data = map_create("analytics-data");
    map_set(data,"installationId",installationID);
    map_set(data,"startTime",flox_date_encode(map_get(newSession,"startTime")));
    map_set(data,"gameVersion",gameVersion);
    map_set(data,"languageCode",os_get_language());
    map_set_map(data,"deviceInfo",deviceInfo);
    
    // If the previous session exists, send more details for it's processing
    // (eg. duration can not be calculated until a session ends)
    var lastLog = noone;
    if map_exists(lastSession){
        map_set(data,"firstStartTime",flox_date_encode(map_get(lastSession,"firstStartTime")));
        map_set(data,"lastStartTime",flox_date_encode(map_get(lastSession,"startTime")));
        map_set(data,"lastDuration",map_get(lastSession,"duration"));
        lastLog = map_get(lastSession,"log");
        map_set_list(data,"lastLog",lastLog);
    }
    
    // POST the logs to the server TODO request_queued
    i_flox_request_queued(http_method_post,"logs",data);
    
    // Delete the last log property so that destroying the data
    // doesn't destroy last sessions log
    map_delete(data,"lastLog");
    // Destroy the data
    map_destroy(deviceInfo);
    map_destroy(data);
}

// Set the current session
map_set_map(self._persistentData,"session",newSession);
// Invalidate the persistent data so that it saves at the next opportunity
i_flox_persistent_invalidate();
