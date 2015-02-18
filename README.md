# Flox SDK - GML (Game Maker Language)

## What is Flox?

Flox is a server backend especially for game developers, providing all the basics you need for a game: analytics, leaderboards, custom entities, and much more. The focus of Flox lies on its scalability (guaranteed by running in the Google App Engine) and ease of use.

While you can communicate with our servers directly via REST, we provide powerful SDKs for the most popular development platforms, including advanced features like offline-support and data caching. With these SDKs, integrating Flox into your game is just a matter of minutes.

More information about Flox can be found here: [Flox, the No-Fuzz Game Backend](http://gamua.com/flox)

## Installing the Extension 

**Step 1:** Sign up to [Flox](http://www.flox.cc/panel/register). Add your game when prompted.
 
**Step 2:** Download the [library](https://bitbucket.org/RaniSputnik/flox-gml/downloads), it should contain three files, ***flox.gml***, ***flox.constants.text*** and ***Flox.object.gmx***.
 
**Step 3.1:** Create a new script group called ***flox***. Right click and Add existing script, select the ***flox.gml*** file and watch the intimidating list of scripts roll in. Minimise that group (quick!).
 
**Step 3.2:** Open the All configurations constants and click load. Select the ***flox.constants.txt*** file. Click OK.
 
**Step 3.3:** Right click Objects and choose Add existing object, select the ***Flox.object.gmx***.
 
Congratulations! Library is all imported and you're ready to start using Flox!

## How to use the GML SDK

Just by **starting up Flox**, you will already generate several interesting analytics charts in the web interface.
```
#!javascript
flox_init("gameID", "gameKey", "1.0");
```
With **Events**, you can collect more finegrained data about how players are using your game. Pass custom properties to get a nice visualization of the details.
```
#!javascript
var event = ds_map_create();
ds_map_add(event,"from","MainMenu");
ds_map_add(event,"to","SettingsMenu");
flox_log_event("MenuNavigation",event);
```
This is just the tip of the iceberg, though! Use Flox to store custom Entities, make Player Logins via a simple e-mail verification or a social network, browse your game's logs, assign custom permissions, and much more.

## Where to go from here?
* Visit [Flox.cc](http://www.flox.cc) for more information about Flox.
* Check out the extension topic on the [Game Maker Community](http://gmc.yoyogames.com/index.php?showtopic=619114#entry4550823)