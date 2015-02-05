/**
 * i_flox_response_add(DSMap map)
 * Notifies Flox that a new response object has been received
 * Queues the response to be processed at the next available moment
 * DO NOT DESTROY MAP, Flox will take control of this maps memory from
 * here on out
 */

var fx = flox_get();
ds_list_add(fx._responses,argument0);
