# Flox SDK - GML (Game Maker Language)

## What is Flox?

Flox is a server backend especially for game developers, providing all the basics 
you need for a game: analytics, leaderboards, custom entities, and much more. The 
focus of Flox lies on its scalability (guaranteed by running in the Google App Engine) 
and ease of use.

While you can communicate with our servers directly via REST, we provide powerful 
SDKs for the most popular development platforms, including advanced features like 
offline-support and data caching. With these SDKs, integrating Flox into your game 
is just a matter of minutes. More information about Flox can be found here: 
[Flox, the No-Fuzz Game Backend](http://gamua.com/flox)

## Installing the Extension 

1. Sign up to [Flox](http://www.flox.cc/panel/register). Add your game when prompted.
2. Get the extension on the [GameMaker Marketplace](https://marketplace.yoyogames.com/assets/574/flox-gm)
or download and import from the [latest release](https://github.com/RaniSputnik/Flox-GML/releases/latest).
3. Congratulations! You're ready to start using Flox!

You will notice that the extension is paid on the marketplace and yet the library is open source
and freely downloadable. I want the library to be accessible to anyone, however I do need to eat!
By all means download for free but ***please*** consider purchasing the library on the 
marketplace. It supports the project and ensures that I can keep giving away code!

## How to use the GML SDK

Just by **starting up Flox**, you will already generate several interesting analytics charts in the web interface.
```
flox_init("gameID", "gameKey", "1.0");
```
With **Events**, you can collect more finegrained data about how players are using your game. Pass custom properties to get a nice visualization of the details.
```
var event = ds_map_create();
ds_map_add(event,"from","MainMenu");
ds_map_add(event,"to","SettingsMenu");
flox_log_event("MenuNavigation",event);
```
This is just the tip of the iceberg, though! Use Flox to store custom Entities, make Player Logins via a simple e-mail verification or a social network, browse your game's logs, assign custom permissions, and much more.

## Where to go from here?
* Check out [the wiki](https://github.com/RaniSputnik/Flox-GML/wiki) for information on how to use the library.
* Visit [Flox.cc](http://www.flox.cc) for more information about Flox.
* Check out the extension topic on the [Game Maker Community](http://gmc.yoyogames.com/index.php?showtopic=619114#entry4550823)

## Building the library

Run the build.py script (requires python 3.4)
