/// flox_get()
//  @return {objFlox}
//  Gets the objFlox singleton. If the flox instance 
//  doesn't exist yet this function will create it.
//  
//  Once you have the flox object you can access various
//  configuration properties. The following properties are
//  available;
//  <pre>
//  var flox = flox_get();
//  flox.secure = true; // Whether or not to make requests over https
//  TODO 
//  </pre>
//  </br>
//  There are also a number of <b>read only</b> properties available.
//  You should not modify these properties;
//  <pre>
//  // Whether or not this is the first time the game was run on this device
//  flox.firstRun = false;
//  </pre>
//  

// Make sure there is at lease one flox instance
if instance_number(objFlox) == 0 then instance_create(0,0,objFlox);

// The objFlox object will check in it's creation code that there isn't
// more than one flox instance :)

// Return the flox singleton
return instance_find(objFlox,0);
