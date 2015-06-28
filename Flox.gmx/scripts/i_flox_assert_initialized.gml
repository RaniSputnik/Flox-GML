/// i_flox_assert_initialized() 
//
// Ensures that Flox is initialized

var fx = flox_get();
if i_flox_assert(fx._initialized,"Call 'flox_init()' before using any other method!") {
    return fx;
}
else return noone;
