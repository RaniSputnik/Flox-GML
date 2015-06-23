/// flox_get()
//
//  Gets the objFlox singleton. If the flox instance 
//  doesn't exist yet this function will create it

// Make sure there is at lease one flox instance
if instance_number(objFlox) == 0 then instance_create(0,0,objFlox);

// The objFlox object will check in it's creation code that there isn't
// more than one flox instance :)

// Return the flox singleton
return instance_find(objFlox,0);